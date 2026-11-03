"""Teste do patch Devarity com fixtures mínimas do upstream auditado."""
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / 'scripts/aplicar-patch.py'
TOKENS = ROOT / 'assets/tokens/devarity-core.json'
FILES = {
 'config/config_appearance.h': '''static const float rootcolor[] = COLOR(0x222222ff);
static const float focused_outer_border_color[] = COLOR(0x005577ff);
static const float unfocused_outer_border_color[] = COLOR(0x444444ff);
''',
 'config/config_animation.h': '''#define tagduration 0.4
#define openduration 0.4
#define closeduration 0.4
#define canvasduration 0.7
#define zoomduration 0.55
''',
 'config/config_keys.h': '''static const char *termcmd[] = { "foot", NULL };
static const char *wlaunch[] = { "wmenu-run", NULL };
{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_f, spawn, {.v = browser} }, /* duplicated */
{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_f, togglefullscreen, {0} },
''',
 'config/config_input.h': '''static const struct xkb_rule_names xkb_rules = {
 .layout = "us",
};
''',
}
class PatchTest(unittest.TestCase):
 def setUp(self):
  self.temp=tempfile.TemporaryDirectory()
  self.root=Path(self.temp.name)
  (self.root/'.git').mkdir()
  for name,content in FILES.items():
   p=self.root/name
   p.parent.mkdir(parents=True,exist_ok=True)
   p.write_text(content)
 def tearDown(self): self.temp.cleanup()
 def run_patch(self):
  return subprocess.run(['python3',str(SCRIPT),str(self.root),str(TOKENS)],capture_output=True,text=True)
 def test_patch(self):
  p=self.run_patch()
  self.assertEqual(p.returncode,0,p.stderr)
  k=(self.root/'config/config_keys.h').read_text()
  self.assertNotIn('{.v = browser}',k)
  self.assertIn('togglefullscreen',k)
  self.assertIn('"kitty"',k)
  self.assertIn('"fuzzel"',k)
  a=(self.root/'config/config_appearance.h').read_text()
  self.assertIn('COLOR(0x8bc9eaff)',a)
  self.assertIn('.variant = "abnt2"',(self.root/'config/config_input.h').read_text())
 def test_refuse_changed_upstream(self):
  (self.root/'config/config_input.h').write_text('ESTRUTURA ALTERADA\n')
  before={n:(self.root/n).read_text() for n in FILES}
  p=self.run_patch()
  self.assertNotEqual(p.returncode,0)
  after={n:(self.root/n).read_text() for n in FILES}
  self.assertEqual(before,after,'Mudanças parciais em caso de falha')
if __name__=='__main__':unittest.main()
