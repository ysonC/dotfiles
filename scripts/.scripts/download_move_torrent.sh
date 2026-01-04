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

get_title_from_magnet() {
    local magnet="$1"
    local dn encoded decoded

    # Extract dn=... (URL-encoded)
    dn="$(printf '%s' "$magnet" | sed -n 's/.*[?&]dn=\([^&]*\).*/\1/p')"

    if [[ -z "$dn" ]]; then
        echo "Unknown title"
        return
    fi

    # URL decode:
    # 1) + -> space
    # 2) %XX -> \xXX then printf %b to interpret
    encoded="${dn//+/ }"
    decoded="${encoded//%/\\x}"

    printf '%b' "$decoded"
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
    local src_dir="$1"
    local dest_dir="$2"

    rsync -aH --info=progress2 \
        --no-perms \
        --no-owner \
        --no-group \
        --inplace \
        --remove-source-files \
        "$src_dir"/ \
        "$dest_dir"/

    find "$src_dir" -type d -empty -delete 2>/dev/null || true
}

if [[ -z "$choice" || -z "$url" ]]; then
    usage
fi

title="$(get_title_from_magnet "$url")"

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

echo ""
echo "==> Downloading: $title"
echo "==> Temp dir: $temp_dir"
echo ""

download "$url" "$temp_dir"

echo ""
echo "==> Moving into: $dest"
echo ""

move_downloaded "$temp_dir" "$dest"

notify-send -t 4000 \
    "Download completed" \
    "$title\nMoved to: $dest"

