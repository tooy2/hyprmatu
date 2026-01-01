#!/usr/bin/env bash

FILE="$HOME/.cache/waypaper"

# أول تطبيق مباشرة إذا كان الملف موجود
if [ -f "$FILE" ]; then
  matugen image "$(cat "$FILE")" --apply
  pkill -SIGUSR2 waybar 2>/dev/null
  hyprctl reload
fi

# راقب أي تغيير على الملف وشغّل Matugen
while inotifywait -e close_write "$FILE"; do
  WALL="$(cat "$FILE")"
  matugen image "$WALL" --apply
  pkill -SIGUSR2 waybar 2>/dev/null
  hyprctl reload
done
