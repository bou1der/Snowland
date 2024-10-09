#!/usr/bin/env bash

# Путь к файлу с обоями
WALLPAPER="$HOME/.config/.current-wallpaper"

# Генерация цветовой схемы с помощью pywal
wal -i "$WALLPAPER" -o wal.json

