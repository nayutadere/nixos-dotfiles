BASE_DIR="$HOME/kani/Screenshots"

MONTH_FOLDER=$(date +%Y-%m)

FILENAME="Screenshot_$(date +%Y%m%d_%H%M%S)"

DEST_DIR="$BASE_DIR/$MONTH_FOLDER"

mkdir -p "$DEST_DIR"
hyprshot -m region -f "$FILENAME" -o "$DEST_DIR"
