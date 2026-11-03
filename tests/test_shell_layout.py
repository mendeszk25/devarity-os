"""Static acceptance checks; NOT a substitute for running Quickshell in Wayland."""
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BASE = ROOT / "desktop/quickshell"

class ShellStructureTests(unittest.TestCase):
    def test_entrypoint_and_panels(self):
        shell = (BASE / "shell.qml").read_text()
        self.assertIn("ShellRoot", shell)
        self.assertEqual(shell.count("model: Quickshell.screens"), 3)
        for comp in ["Topbar", "Dock", "AppMenu"]:
            self.assertTrue((BASE / f"{comp}.qml").is_file())
            self.assertRegex(shell, rf"\b{comp}\s*\{{")
        for comp in ["Topbar", "Dock", "AppMenu"]:
            content = (BASE / f"{comp}.qml").read_text()
            self.assertIn("required property var modelData", content)
            self.assertIn("screen: modelData", content)
            self.assertIn("ExclusionMode.Ignore", content)

    def test_menu_uses_real_desktop_entries(self):
        content = (BASE / "AppMenu.qml").read_text()
        self.assertIn("DesktopEntries.applications.values", content)
        self.assertIn("entry.execute()", content)
        self.assertIn("ScriptModel", content)
        self.assertNotIn('["sh", "-c"', content)

    def test_menu_keyboard_shortcuts(self):
        content = (BASE / "AppMenu.qml").read_text()
        for action in ("Keys.onEscapePressed", "Keys.onDownPressed", "Keys.onUpPressed", "onAccepted"):
            self.assertIn(action, content)
        self.assertIn("ListView.isCurrentItem", content)
        self.assertIn("menu.launch(entryRow.modelData)", content)

    def test_launcher_and_safety(self):
        dock = (BASE / "Dock.qml").read_text()
        for cmd in ("kitty", "dolphin", "fuzzel"):
            self.assertIn(f'"{cmd}"', dock)
        script = (ROOT / "scripts/20-testar-shell.sh").read_text()
        self.assertIn("WAYLAND_DISPLAY", script)
        self.assertIn("exec quickshell --path", script)
        self.assertNotIn("make install", script)
        self.assertNotIn("systemctl enable", script)
        self.assertNotIn("sudo rm", script)

if __name__ == "__main__":
    unittest.main()
