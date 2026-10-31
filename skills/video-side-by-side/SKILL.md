---
name: video-side-by-side
description: Combine two videos side by side with ffmpeg, especially dashcam/front-rear clips. Use when Codex needs to trim time ranges, place a front/left view beside a rear/right view, output video-only MP4, preserve the source codec family when filtering forces re-encoding, resize/downsample, or fit the final video under a size limit.
---

# Video Side By Side

## Workflow

Use `scripts/side_by_side_video.py` for repeatable ffmpeg command construction.

1. Identify the intended left and right inputs from filenames or user instructions. For dashcam clips, treat `F` or `front` as left and `R` or `rear` as right unless the user says otherwise.
2. Inspect streams with `ffprobe` when the inputs are unknown:

```bash
ffprobe -hide_banner -select_streams v:0 \
  -show_entries stream=codec_name,width,height,r_frame_rate \
  -show_entries format=duration \
  -of default=noprint_wrappers=1 input.mov
```

3. Build from original inputs, not from a prior compressed output.
4. Use filtering for trim/resize/hstack, so stream copy is impossible. Interpret "keep the codec" as preserving the codec family: H.264 input becomes H.264 MP4 output; HEVC input becomes HEVC MP4 output. Fall back to H.264 if the source codec is unsuitable for MP4 or unavailable.
5. Use `-an` for video-only output unless the user explicitly asks for audio.
6. Verify output with `ffprobe` and `ls -lh`.

## Script Usage

Basic front-left/rear-right trim:

```bash
python3 /path/to/video-side-by-side/scripts/side_by_side_video.py \
  --left F_clip.MOV \
  --right R_clip.MOV \
  --start 00:00:07 \
  --end 00:00:39 \
  --output combined.mp4
```

Fit under a size cap by downsampling each side and computing a bounded bitrate:

```bash
python3 /path/to/video-side-by-side/scripts/side_by_side_video.py \
  --left F_clip.MOV \
  --right R_clip.MOV \
  --start 00:00:07 \
  --end 00:00:39 \
  --each-height 900 \
  --max-size-mib 80 \
  --fps 30 \
  --output combined_under80mb.mp4
```

Use `--print-command` to review the generated ffmpeg command without running it.

## Parameter Guidance

- Prefer `--start` and `--end` for exact clip ranges. The output duration is `end - start`.
- Use `--each-height` when the user says to downsample "a little bit"; for 1920x1080 inputs, `--each-height 900` yields 1600x900 per side and 3200x900 final output.
- Use `--max-size-mib` when a final file size limit matters. The script reserves container overhead and sets `-b:v`, `-maxrate`, and `-bufsize`.
- Keep the default retry behavior for hard size caps. The script checks the output size and lowers the bitrate if the first encode exceeds the cap.
- Use `--fps` when inputs have different frame rates. For mixed 30 fps and 25 fps dashcam clips, use `--fps 30` if the left/front stream is 30 fps and smoothness matters.
- Use `--crf` when no hard size target exists. A CRF around 18 is visually conservative for H.264.

## Verification

After encoding, run:

```bash
ffprobe -hide_banner \
  -show_entries format=format_name,duration,size \
  -show_entries stream=index,codec_type,codec_name,width,height,r_frame_rate,duration \
  -of default=noprint_wrappers=1 output.mp4
ls -lh output.mp4
```

Confirm MP4 container, one video stream, no audio stream, expected codec, expected duration, expected side-by-side dimensions, and size below the requested limit.
