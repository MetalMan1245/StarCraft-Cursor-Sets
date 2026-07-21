#!/usr/bin/env python3

import subprocess
import sys
import tempfile
import shutil
from pathlib import Path


def parse_conf(conf_path):
    frames = []

    with conf_path.open() as f:
        for lineno, line in enumerate(f, 1):
            line = line.strip()

            if not line or line.startswith("#"):
                continue

            parts = line.split()

            if len(parts) != 5:
                raise ValueError(
                    f"{conf_path.name}:{lineno}: expected 5 fields, got {len(parts)}"
                )

            size, xhot, yhot, image, delay = parts

            frames.append({
                "size": int(size),
                "xhot": int(xhot),
                "yhot": int(yhot),
                "image": image,
                "delay": int(delay),
            })

    if not frames:
        raise ValueError("contains no frames")

    first = frames[0]

    for frame in frames[1:]:
        if frame["size"] != first["size"]:
            raise ValueError("frame sizes differ")
        if frame["xhot"] != first["xhot"]:
            raise ValueError("x hotspots differ")
        if frame["yhot"] != first["yhot"]:
            raise ValueError("y hotspots differ")
        if frame["delay"] != first["delay"]:
            raise ValueError(
                "frame delays differ (ClickGen supports only one delay)"
            )

    return first, frames


def build_cursor(conf_path, linux_dir, windows_dir):
    first, frames = parse_conf(conf_path)

    with tempfile.TemporaryDirectory() as temp:
        temp = Path(temp)

        cmd = [
            "clickgen",
            "-o", str(temp),
            "-p", "all",
            "-x", str(first["xhot"]),
            "-y", str(first["yhot"]),
            "-s", str(first["size"]),
            "-d", str(first["delay"]),
        ]

        for frame in frames:
            image = conf_path.parent / frame["image"]

            if not image.exists():
                raise FileNotFoundError(image)

            cmd.append(str(image))

        subprocess.run(cmd, check=True)

        generated = list(temp.iterdir())

        if not generated:
            raise RuntimeError("ClickGen produced no output")

        for file in generated:
            suffix = file.suffix.lower()

            if suffix == ".cur" or suffix == ".ani":
                shutil.move(
                    str(file),
                    str(windows_dir / f"{conf_path.stem}{suffix}")
                )

            elif suffix == "":
                shutil.move(
                    str(file),
                    str(linux_dir / conf_path.stem)
                )

            else:
                raise RuntimeError(
                    f"Unexpected ClickGen output: {file.name}"
                )


def main():
    if len(sys.argv) != 2:
        print(f"Usage: {Path(sys.argv[0]).name} <cursor-directory>")
        sys.exit(1)

    root = Path(sys.argv[1]).resolve()

    if not root.is_dir():
        print(f"'{root}' is not a directory.")
        sys.exit(1)

    linux_dir = root / "cursors"
    windows_dir = root / "windows"

    linux_dir.mkdir(exist_ok=True)
    windows_dir.mkdir(exist_ok=True)

    for conf in sorted(root.glob("*.conf")):
        print(f"Generating {conf.stem}...")

        try:
            build_cursor(conf, linux_dir, windows_dir)
        except Exception as e:
            print(f"  ERROR: {e}")


if __name__ == "__main__":
    main()
