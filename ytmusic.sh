#!/usr/bin/env bash

if ! command -v yt-dlp &>/dev/null; then
  echo "yt-dlp not found, entering nix-shell..."
  exec nix-shell -p yt-dlp ffmpeg --run "$0 $*"
fi

yt-dlp \
  --extract-audio \
  --audio-format opus \
  --audio-quality 0 \
  --embed-thumbnail \
  --embed-metadata \
  -o "%(artist)s/%(album)s/%(track_number)02d - %(title)s.%(ext)s" \
  "$@"