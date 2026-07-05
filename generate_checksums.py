#!/usr/bin/env python3
"""
generate_checksums.py – Generate or verify SHA-256 checksums for lib/Desc_*

Usage:
    python3 generate_checksums.py              # generate lib/SHA256SUMS
    python3 generate_checksums.py --verify     # verify against lib/SHA256SUMS
    python3 generate_checksums.py --workers 16 # parallel worker count
"""

import argparse
import hashlib
import sys
import time
from multiprocessing import Pool, cpu_count
from pathlib import Path


def _sha256(path_str: str) -> tuple:
    p = Path(path_str)
    h = hashlib.sha256()
    with open(p, "rb") as fh:
        for chunk in iter(lambda: fh.read(1 << 20), b""):
            h.update(chunk)
    return (path_str, h.hexdigest())


def _fmt_eta(seconds: float) -> str:
    seconds = int(seconds)
    if seconds < 60:
        return f"{seconds}s"
    if seconds < 3600:
        return f"{seconds // 60}m{seconds % 60:02d}s"
    return f"{seconds // 3600}h{(seconds % 3600) // 60:02d}m"


def collect_paths(lib_dir: Path) -> list:
    paths = []
    for d in sorted(lib_dir.glob("Desc_*")):
        if not d.is_dir():
            continue
        for p in sorted(d.iterdir()):
            if p.name.endswith(".g.gz") or (p.name.endswith(".g") and not p.name.endswith(".gz")):
                paths.append(str(p))
    return paths


def generate(lib_dir: Path, workers: int) -> None:
    sums_file = lib_dir / "SHA256SUMS"

    print("Collecting files …", end="", flush=True)
    paths = collect_paths(lib_dir)
    total = len(paths)
    print(f"\r Hashing {total:,} files with {workers} workers …      ", flush=True)

    results = {}
    start = time.time()
    last_print = start

    with Pool(workers) as pool:
        for i, (path_str, digest) in enumerate(
            pool.imap_unordered(_sha256, paths, chunksize=100), start=1
        ):
            results[path_str] = digest
            now = time.time()
            if now - last_print >= 1.0 or i == total:
                elapsed = now - start
                rate = i / elapsed if elapsed > 0 else 0
                eta = _fmt_eta((total - i) / rate) if rate > 0 else "?"
                print(
                    f"\r  {i:,}/{total:,}  ({100*i//total}%)  "
                    f"{rate:,.0f} files/s  ETA {eta}",
                    end="", flush=True,
                )
                last_print = now

    elapsed = time.time() - start
    print(f"\r  {total:,}/{total:,}  (100%)  done in {_fmt_eta(elapsed)}          ")

    with open(sums_file, "w") as fh:
        for path_str in sorted(results):
            rel = Path(path_str).relative_to(lib_dir.parent)
            fh.write(f"{results[path_str]}  {rel}\n")

    print(f"Written: {sums_file}  ({total:,} entries)")


def verify(lib_dir: Path, workers: int) -> None:
    sums_file = lib_dir / "SHA256SUMS"
    if not sums_file.exists():
        sys.exit(f"ERROR: {sums_file} not found — run without --verify to generate it")

    entries = {}
    script_dir = lib_dir.parent
    with open(sums_file) as fh:
        for line in fh:
            line = line.rstrip("\n")
            if not line:
                continue
            digest, rel_path = line.split("  ", 1)
            abs_path = str(script_dir / rel_path)
            entries[abs_path] = digest

    total = len(entries)
    print(f"Verifying {total:,} files …", flush=True)

    mismatches = []
    missing = []
    start = time.time()
    last_print = start

    paths = list(entries)
    with Pool(workers) as pool:
        for i, (path_str, actual) in enumerate(
            pool.imap_unordered(_sha256, paths, chunksize=100), start=1
        ):
            expected = entries[path_str]
            if actual != expected:
                mismatches.append(path_str)

            now = time.time()
            if now - last_print >= 1.0 or i == total:
                elapsed = now - start
                rate = i / elapsed if elapsed > 0 else 0
                eta = _fmt_eta((total - i) / rate) if rate > 0 else "?"
                print(
                    f"\r  {i:,}/{total:,}  ({100*i//total}%)  "
                    f"{rate:,.0f} files/s  ETA {eta}  "
                    f"{len(mismatches)} mismatch(es)",
                    end="", flush=True,
                )
                last_print = now

    elapsed = time.time() - start
    print(f"\r  {total:,}/{total:,}  (100%)  done in {_fmt_eta(elapsed)}          ")

    for path_str in sorted(paths):
        if not Path(path_str).exists():
            missing.append(path_str)

    if missing:
        for p in missing:
            print(f"MISSING  {p}", file=sys.stderr)
    if mismatches:
        for p in sorted(mismatches):
            print(f"MISMATCH  {p}", file=sys.stderr)

    total_bad = len(missing) + len(mismatches)
    if total_bad:
        sys.exit(f"\n{total_bad} problem(s) found.")
    else:
        print(f"All {total:,} files OK.")


def main() -> None:
    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument("--verify", action="store_true", help="Verify against lib/SHA256SUMS")
    parser.add_argument(
        "--workers", type=int, default=min(cpu_count(), 8), help="Parallel workers (default: CPU count)"
    )
    args = parser.parse_args()

    lib_dir = Path(__file__).parent / "lib"
    if not lib_dir.is_dir():
        sys.exit(f"ERROR: lib/ not found at {lib_dir}")

    if args.verify:
        verify(lib_dir, args.workers)
    else:
        generate(lib_dir, args.workers)


if __name__ == "__main__":
    main()
