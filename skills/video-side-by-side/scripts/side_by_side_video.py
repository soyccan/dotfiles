#!/usr/bin/env python3
"""Build and run an ffmpeg side-by-side video encode."""

from __future__ import annotations

import argparse
import json
import shlex
import subprocess
import sys
from pathlib import Path


def parse_time(value: str) -> float:
    parts = value.split(":")
    if len(parts) == 1:
        return float(parts[0])
    if len(parts) == 2:
        minutes, seconds = parts
        return int(minutes) * 60 + float(seconds)
    if len(parts) == 3:
        hours, minutes, seconds = parts
        return int(hours) * 3600 + int(minutes) * 60 + float(seconds)
    raise argparse.ArgumentTypeError(f"invalid time value: {value}")


def ffprobe_video(path: Path) -> dict[str, str]:
    cmd = [
        "ffprobe",
        "-v",
        "error",
        "-select_streams",
        "v:0",
        "-show_entries",
        "stream=codec_name,width,height,r_frame_rate",
        "-of",
        "json",
        str(path),
    ]
    proc = subprocess.run(cmd, check=True, text=True, capture_output=True)
    data = json.loads(proc.stdout)
    streams = data.get("streams", [])
    if not streams:
        raise RuntimeError(f"no video stream found in {path}")
    return streams[0]


def codec_encoder(codec_name: str) -> tuple[str, list[str]]:
    normalized = codec_name.lower()
    if normalized in {"h264", "avc1"}:
        return "libx264", ["-profile:v", "main", "-pix_fmt", "yuv420p"]
    if normalized in {"hevc", "h265"}:
        return "libx265", ["-pix_fmt", "yuv420p"]
    return "libx264", ["-profile:v", "main", "-pix_fmt", "yuv420p"]


def build_filter(args: argparse.Namespace) -> str:
    stages = []
    labels = ("left", "right")
    for input_index, label in enumerate(labels):
        filters = [
            f"trim=start={args.start_seconds}:end={args.end_seconds}",
            "setpts=PTS-STARTPTS",
        ]
        if args.fps:
            filters.append(f"fps={args.fps}")
        if args.each_height:
            filters.append(f"scale=-2:{args.each_height}:flags=lanczos")
        elif args.each_width:
            filters.append(f"scale={args.each_width}:-2:flags=lanczos")
        filters.append("setsar=1")
        stages.append(f"[{input_index}:v]{','.join(filters)}[{label}]")
    stages.append("[left][right]hstack=inputs=2[v]")
    return ";".join(stages)


def format_kbps(bits_per_second: float) -> str:
    return f"{max(100, int(bits_per_second / 1000))}k"


def build_command(args: argparse.Namespace) -> list[str]:
    left_info = ffprobe_video(args.left)
    encoder, codec_flags = codec_encoder(left_info.get("codec_name", "h264"))
    duration = args.end_seconds - args.start_seconds
    if duration <= 0:
        raise ValueError("--end must be greater than --start")

    cmd = [
        "ffmpeg",
        "-hide_banner",
        "-y",
        "-i",
        str(args.left),
        "-i",
        str(args.right),
        "-filter_complex",
        build_filter(args),
        "-map",
        "[v]",
        "-an",
        "-c:v",
        encoder,
        *codec_flags,
    ]

    if args.max_size_mib:
        target_bits = args.max_size_mib * 1024 * 1024 * 8 * args.size_margin
        bitrate = target_bits / duration
        cmd.extend(["-b:v", format_kbps(bitrate), "-maxrate", format_kbps(bitrate)])
        cmd.extend(["-bufsize", format_kbps(bitrate * 2)])
    else:
        cmd.extend(["-crf", str(args.crf)])

    cmd.extend(["-preset", args.preset, "-movflags", "+faststart", str(args.output)])
    return cmd


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Trim two videos, stack them left/right, and output video-only MP4."
    )
    parser.add_argument("--left", required=True, type=Path, help="left-side input video")
    parser.add_argument("--right", required=True, type=Path, help="right-side input video")
    parser.add_argument("--output", required=True, type=Path, help="output .mp4 path")
    parser.add_argument("--start", required=True, help="start time, e.g. 7 or 00:00:07")
    parser.add_argument("--end", required=True, help="end time, e.g. 39 or 00:00:39")
    parser.add_argument("--fps", type=float, help="output frame rate")
    parser.add_argument("--each-height", type=int, help="scale each side to this height")
    parser.add_argument("--each-width", type=int, help="scale each side to this width")
    parser.add_argument("--max-size-mib", type=float, help="target maximum output size in MiB")
    parser.add_argument("--size-margin", type=float, default=0.94, help="bitrate safety margin")
    parser.add_argument("--retries", type=int, default=2, help="size-cap retry attempts")
    parser.add_argument("--crf", type=float, default=18, help="CRF when no size cap is set")
    parser.add_argument("--preset", default="veryfast", help="ffmpeg encoder preset")
    parser.add_argument("--print-command", action="store_true", help="print command only")
    args = parser.parse_args()

    if args.each_height and args.each_width:
        parser.error("use only one of --each-height or --each-width")

    args.start_seconds = parse_time(args.start)
    args.end_seconds = parse_time(args.end)

    if args.print_command:
        cmd = build_command(args)
        print(shlex.join(cmd))
        return 0

    max_bytes = args.max_size_mib * 1024 * 1024 if args.max_size_mib else None
    attempts = max(0, args.retries) + 1
    for attempt in range(attempts):
        cmd = build_command(args)
        print(shlex.join(cmd), flush=True)
        rc = subprocess.run(cmd).returncode
        if rc != 0:
            return rc
        if max_bytes is None:
            return 0
        size = args.output.stat().st_size
        if size <= max_bytes:
            return 0
        if attempt + 1 < attempts:
            print(
                f"output is {size} bytes, above cap {int(max_bytes)}; "
                "retrying with lower bitrate",
                file=sys.stderr,
                flush=True,
            )
            args.size_margin *= (max_bytes / size) * 0.95

    print(
        f"output is {args.output.stat().st_size} bytes, above cap {int(max_bytes)}",
        file=sys.stderr,
    )
    return 2


if __name__ == "__main__":
    sys.exit(main())
