#!/bin/bash



CSV_FILE=$1
DEST_FOLDER=$2


mkdir -p "$DEST_FOLDER"
cut -d, -f1 "$CSV_FILE" | while read -r url; do
if [[ ! -z "$url" ]]; then

filename=$(basename "$url")
wget -q "$url" -O "$DEST_FOLDER/$filename"
echo "Downloaded $filename"
fi
done
