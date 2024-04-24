#!/usr/bin/env python 

import os
from pathlib import Path


cache = f"{Path.home()}/.cache/wal"
config = f"{Path.home()}/.config"


def symlink():
    to_link = {
        f"{cache}/00-colors.conf": f"{config}/dunst/dunstrc.d/00-colors.conf",
        f"{cache}/colors-ags.css": f"{config}/ags/style/colors.css",
        f"{cache}/colors-hyprland.conf" : f"{config}/hypr/colors-hyprland.conf"
    }
    for src, dst in to_link.items():
        if not(Path(dst).exists()) and Path(src).exists():
            os.symlink(src, dst)
            print(f"Symlink {src}")


if __name__ == "__main__":
    os.system(f"{Path.home()}/.local/bin/wal --theme base16-tomorrow-night")
    symlink()
