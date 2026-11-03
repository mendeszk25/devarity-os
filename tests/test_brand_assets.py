"""Offline regression checks for project-owner-provided logos."""
from pathlib import Path
import struct
import unittest

ROOT = Path(__file__).resolve().parents[1]
ASSETS = ROOT / "assets/branding"

class BrandingTests(unittest.TestCase):
    def test_png_signatures(self):
        for name in ("devarity-mark-light.png", "devarity-mark-dark.png"):
            data = (ASSETS / name).read_bytes()
            self.assertEqual(data[:8], b"\x89PNG\r\n\x1a\n")
            self.assertEqual(struct.unpack(">II", data[16:24]), (64,64))
            self.assertLess(len(data), 12000)
            # The light mark used by the UI should be standard 8-bit RGBA PNG.
            if name == "devarity-mark-light.png":
                self.assertEqual(data[24], 8)  # bit depth
                self.assertEqual(data[25], 6)  # PNG color type RGBA

    def test_documentation(self):
        self.assertIn("Devarity OS", (ASSETS / "README.md").read_text())

if __name__ == "__main__":
    unittest.main()
