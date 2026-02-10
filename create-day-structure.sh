#!/usr/bin/env sh
# create-day-structure.sh
# Creates folder structure like day-02: assets/fonts, assets/images, design
# Usage: ./create-day-structure.sh   or   sh create-day-structure.sh

STRUCTURE="assets/fonts
assets/images
assets/icons
design"

echo "Create day-02 style folder structure"
echo "Structure: assets/fonts, assets/images, assets/icons, design"
echo ""

printf "Enter full path of folder where to create structure (e.g. ./day-15 or /home/user/project/day-15): "
read -r TARGET_DIR

# Trim leading/trailing whitespace (works in sh)
TARGET_DIR=$(echo "$TARGET_DIR" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

if [ -z "$TARGET_DIR" ]; then
    echo "No path entered. Exiting."
    exit 1
fi

# Resolve path (handle relative paths)
case "$TARGET_DIR" in
    /*) ;;
    *) TARGET_DIR="$(pwd)/$TARGET_DIR"
esac

# Normalize path: remove duplicate slashes and /./ (helps avoid oddities)
TARGET_DIR=$(echo "$TARGET_DIR" | sed 's|/\./|/|g;s|/\+|/|g;s|/$||')

echo ""
echo "Will create structure under: $TARGET_DIR"
printf "Proceed? [y/N]: "
read -r CONFIRM
case "$CONFIRM" in
    [yY]|[yY][eE][sS]) ;;
    *) echo "Cancelled."; exit 0
esac

# Create base folder
mkdir -p "$TARGET_DIR" || { echo "Failed to create base folder."; exit 1; }

for rel in $STRUCTURE; do
    full="$TARGET_DIR/$rel"
    if [ -d "$full" ]; then
        echo "Exists:  $full"
    else
        mkdir -p "$full" && echo "Created: $full"
    fi
done

echo ""
echo "Done. Folder structure created under: $TARGET_DIR"
