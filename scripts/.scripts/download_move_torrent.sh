#!/usr/bin/env bash
set -euo pipefail

choice=${1:-}
url=${2:-}

# File path
MOVIE=/mnt/bigBoi/Movie
SERIES=/mnt/bigBoi/Series

usage() {
    cat <<EOF
Usage: $0 [Choice] [Magnet Link]

  -m    Download to $MOVIE
  -s    Download to $SERIES

Example:
  $0 -m "MAGNET_LINK"
EOF
    exit 1
}

download() {
    local link="$1"
    local dir="$2"

    aria2c \
        --dir="$dir" \
        --seed-time=0 \
        --bt-stop-timeout=0 \
        "$link"
}

move_downloaded() {
    # Trigger automount
    # ls -ld /mnt/bigboi >/dev/null

    local src_dir="$1"
    local dest_dir="$2"

    # Move whatever aria2c wrote into the temp directory.
    # Using rsync keeps it robust for large files and nested dirs.
    rsync -aH --info=progress2 \
        --no-perms \
        --no-owner \
        --no-group \
        --inplace \
        --remove-source-files \
        "$src_dir"/ \
        "$dest_dir"/

    # Clean up any empty directories left behind
    find "$src_dir" -type d -empty -delete 2>/dev/null || true
}

if [[ -z "$choice" || -z "$url" ]]; then
    usage
fi

# Per-run temp dir; auto-clean on exit (success or failure)
temp_dir="$(mktemp -d /tmp/torrent_download.XXXXXX)"
cleanup() {
    rm -rf -- "$temp_dir"
}
trap cleanup EXIT

case "$choice" in
    -m)
        dest="$MOVIE"
        ;;
    -s)
        dest="$SERIES"
        ;;
    *)
        usage
        ;;
esac

# mkdir -p -- "$dest"

echo "Downloading to temp: $temp_dir"
download "$url" "$temp_dir"

echo "Moving into: $dest"
move_downloaded "$temp_dir" "$dest"

