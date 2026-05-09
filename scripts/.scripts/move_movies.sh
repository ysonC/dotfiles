#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$HOME/movie"
DEST_DIR="/mnt/bigBoi/Movie"

usage() {
    cat <<EOF
Usage: $0

This script will:
  1. Print all movie folders/files found in: $SRC_DIR
  2. Move them to: $DEST_DIR
  3. Ask whether to delete any remaining contents in $SRC_DIR
EOF
    exit 1
}

print_found_movies() {
    local src="$1"

    echo "==> Found items in $src:"
    echo ""

    find "$src" -mindepth 1 -maxdepth 1 -print0 |
    while IFS= read -r -d '' item; do
        printf ' - %s\n' "$(basename "$item")"
    done

    echo ""
}

move_one() {
    local item="$1"
    local dest="$2"

    rsync -aH --info=progress2 \
        --no-perms \
        --no-owner \
        --no-group \
        --inplace \
        --remove-source-files \
        "$item" \
        "$dest"/

    # Clean up empty directories left behind
    if [[ -d "$item" ]]; then
        find "$item" -type d -empty -delete 2>/dev/null || true
        rmdir "$item" 2>/dev/null || true
    fi
}

prompt_delete_remaining() {
    local src="$1"

    if [[ -z "$(find "$src" -mindepth 1 -print -quit 2>/dev/null)" ]]; then
        echo "==> Source directory is already empty."
        return
    fi

    echo ""
    echo "==> Remaining items in $src:"
    find "$src" -mindepth 1 -maxdepth 1 -print0 |
    while IFS= read -r -d '' item; do
        printf ' - %s\n' "$(basename "$item")"
    done
    echo ""

    read -r -p "Delete all remaining items in $src? [y/N]: " confirm

    case "$confirm" in
        [yY]|[yY][eE][sS])
            find "$src" -mindepth 1 -maxdepth 1 -exec rm -rf -- {} +
            echo "==> Remaining items deleted."
            ;;
        *)
            echo "==> Remaining items kept."
            ;;
    esac
}

main() {
    [[ $# -eq 0 ]] || usage

    if [[ ! -d "$SRC_DIR" ]]; then
        echo "Source directory does not exist: $SRC_DIR"
        exit 1
    fi

    if [[ ! -d "$DEST_DIR" ]]; then
        echo "Destination directory does not exist: $DEST_DIR"
        exit 1
    fi

    if [[ -z "$(find "$SRC_DIR" -mindepth 1 -maxdepth 1 -print -quit 2>/dev/null)" ]]; then
        echo "Nothing to move from: $SRC_DIR"
        exit 0
    fi

    print_found_movies "$SRC_DIR"

    echo "==> Moving all items from: $SRC_DIR"
    echo "==> Destination: $DEST_DIR"
    echo ""

    find "$SRC_DIR" -mindepth 1 -maxdepth 1 -print0 |
    while IFS= read -r -d '' item; do
        echo "==> Moving: $(basename "$item")"
        move_one "$item" "$DEST_DIR"
        echo ""
    done

    echo "==> Move completed."

    notify-send -t 4000 \
        "Movie move completed" \
        "Moved all items from $SRC_DIR to $DEST_DIR"

    prompt_delete_remaining "$SRC_DIR"
}

main "$@"
