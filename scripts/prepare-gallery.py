#!/usr/bin/env python3
"""Prepare the gallery assets from the DAML paper sources.

Copies the full-resolution PNGs unchanged (lossless), generates small JPEG
thumbnails, and records image dimensions for the PhotoSwipe viewer.

Usage:
    python3 scripts/prepare-gallery.py [--source DIR] [--force]
"""

from __future__ import annotations

import argparse
import json
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DEFAULT_SOURCE = Path.home() / "work" / "papers" / "daml-paper" / "images"

# Russian morphology layout, chapter 7 of the paper.
MORPHOLOGY = [
    "ru-layout-pre-0-65",
    "ru-layout-pre-0-71",
    "ru-layout-pre-0-77",
    "ru-layout-pre-0-81",
    "ru-layout-pre-0-85",
    "ru-layout-root-1",
    "ru-layout-root-2",
    "ru-layout-root-3",
    "ru-layout-root-4",
    "ru-layout-root-5",
    "ru-layout-fix-0-65",
    "ru-layout-fix-0-75",
    "ru-layout-fix-0-8",
    "ru-layout-fix-0-85",
    "ru-layout-fix-0-9",
    "ru-layout-suffix-1",
    "ru-layout-suffix-2",
    "ru-layout-suffix-3",
    "ru-layout-suffix-4",
    "ru-layout-suffix-5",
    "ru-layout-before-patch",
    "ru-layout-after-patch",
    "ru-relayout-after-patch",
    "ru-layout-after-table-codes",
    "ru-layout-final",
]

# Histochemistry section, chapter 7.
HISTOCHEMISTRY = [
    "tls-1",
    "tls-2",
    "tls-3",
    "tls-4",
    "hist-cd4-cd8a",
    "hist-cd4-pd1",
    "hist-cd4",
    "hist-pd1",
]

IMAGES = MORPHOLOGY + HISTOCHEMISTRY

FULL_DIR = ROOT / "assets" / "gallery" / "full"
THUMB_DIR = ROOT / "assets" / "gallery" / "thumbs"
DIMS_FILE = ROOT / "_lib" / "gallery-images.json"

THUMB_SIZE = "480x480>"
THUMB_QUALITY = "82"


def run(cmd: list[str]) -> str:
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        raise RuntimeError(f"{' '.join(cmd)} failed:\n{result.stderr}")
    return result.stdout.strip()


def dimensions(path: Path) -> tuple[int, int]:
    out = run(["identify", "-format", "%w %h", str(path)])
    width, height = out.split()
    return int(width), int(height)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, default=DEFAULT_SOURCE)
    parser.add_argument(
        "--force",
        action="store_true",
        help="Regenerate assets that already exist.",
    )
    args = parser.parse_args()

    if not args.source.is_dir():
        print(f"error: source directory not found: {args.source}", file=sys.stderr)
        return 1

    FULL_DIR.mkdir(parents=True, exist_ok=True)
    THUMB_DIR.mkdir(parents=True, exist_ok=True)
    DIMS_FILE.parent.mkdir(parents=True, exist_ok=True)

    dims: dict[str, dict[str, int]] = {}
    missing: list[str] = []

    for name in IMAGES:
        source = args.source / f"{name}.png"
        if not source.exists():
            missing.append(name)
            continue

        full = FULL_DIR / f"{name}.png"
        thumb = THUMB_DIR / f"{name}.jpg"

        if args.force or not full.exists():
            shutil.copy2(source, full)
        if args.force or not thumb.exists():
            run(
                [
                    "convert",
                    str(source),
                    "-auto-orient",
                    "-strip",
                    "-resize",
                    THUMB_SIZE,
                    "-quality",
                    THUMB_QUALITY,
                    "-sampling-factor",
                    "4:2:0",
                    str(thumb),
                ]
            )

        width, height = dimensions(source)
        dims[name] = {"width": width, "height": height}

    if missing:
        print(f"error: missing source images: {', '.join(missing)}", file=sys.stderr)
        return 1

    DIMS_FILE.write_text(json.dumps(dims, indent=2, sort_keys=True) + "\n")

    full_bytes = sum(p.stat().st_size for p in FULL_DIR.glob("*.png"))
    thumb_bytes = sum(p.stat().st_size for p in THUMB_DIR.glob("*.jpg"))
    print(f"{len(dims)} images")
    print(f"  full:  {full_bytes / 1e6:6.1f} MB")
    print(f"  thumbs:{thumb_bytes / 1e6:6.1f} MB")
    print(f"  dims:  {DIMS_FILE.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
