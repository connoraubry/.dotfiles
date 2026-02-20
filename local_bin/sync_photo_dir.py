#!/usr/local/bin/python3

import argparse
from pathlib import Path
import sys
import shutil


raw_extensions = [
    '.CR2', '.RW2', '.ERF',
    '.NRW', '.NEF', '.DNG',
    '.RAF', '.ARW', '.DCR',
    '.RAW',
]


def get_file_dirs(p: Path) -> tuple[Path, Path]:

    raw_path = p / "raw"
    jpeg_path = p / "jpeg"

    if raw_path.is_dir() and jpeg_path.is_dir():
        return raw_path, jpeg_path

    for dir in p.glob("*"):
        if not dir.is_dir():
            continue
        if dir.stem.lower() == "raw":
            raw_path = p / dir
        if dir.stem.lower() == "jpeg":
            jpeg_path = p / dir
    return raw_path, jpeg_path


def parse_args():

    parser = argparse.ArgumentParser(
        "File sync", description="Sync files between jpeg and raw folders for quick culling")

    parser.add_argument("root_dir", type=str,
                        help="Root directory for comparing files")
    parser.add_argument("--verbose", dest="verbose",
                        help="verbose", action="store_true")
    parser.add_argument("--recursive", dest="recursive",
                        help="run recursively. will check for raw/jpeg combo in all child dirs", action="store_true")
    return parser.parse_args()


def sync_dir(root, raw, jpeg) -> int:

    raw_files = {f.stem: f for f in raw.glob(
        "*") if f.suffix.upper() in raw_extensions}
    jpeg_files = {f.stem: f for f in jpeg.glob("*")}

    raw_stems = set([x for x in raw_files.keys()])
    jpeg_stems = set([x for x in jpeg_files.keys()])

    jpeg_extra = jpeg_stems - raw_stems
    raw_extra = raw_stems - jpeg_stems

    delete_dir = root / "delete_dir"
    delete_dir.mkdir(exist_ok=True)

    count = 0
    for stem in jpeg_extra:
        jpeg_file = jpeg_files[stem]
        shutil.move(jpeg_file, delete_dir / jpeg_file.name)
        count += 1

    for stem in raw_extra:
        raw_file = raw_files[stem]
        shutil.move(raw_file, delete_dir / raw_file.name)
        count += 1

    return count


def main():

    args = parse_args()

    root = Path(args.root_dir)
    if not root.is_dir():
        print("error: must point to a directory")
        sys.exit(1)

    if not args.recursive:
        raw, jpeg = get_file_dirs(root)

        if not raw.is_dir() or not jpeg.is_dir():
            print("error: need both raw and jpeg directories")
            sys.exit(1)

        count = sync_dir(root, raw, jpeg)
        print(f"transferred {count} files in directory {root}")
        return

    dirs = [root]

    while len(dirs) > 0:
        curr_root = dirs.pop(0)

        for child_dir in curr_root.glob("*"):
            if not child_dir.is_dir():
                continue
            dirs.append(child_dir)

        raw, jpeg = get_file_dirs(curr_root)

        if not raw.is_dir() or not jpeg.is_dir():
            continue

        count = sync_dir(curr_root, raw, jpeg)
        print(f"transferred {count} files in directory {curr_root}")


if __name__ == '__main__':
    main()
