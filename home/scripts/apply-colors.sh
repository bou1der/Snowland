#!/usr/bin/env bash

# Путь к файлу с обоями
WALLPAPER="$HOME/.current-wallpaper"

# Генерация цветовой схемы с помощью pywal
wal -i "$WALLPAPER"

# Применение цветовой схемы к Kitty
if [ -f "$HOME/.cache/wal/colors-kitty.conf" ]; then
    ln -sf "$HOME/.cache/wal/colors-kitty.conf" "$HOME/.config/kitty/kitty.conf"
fi

# Применение цветовой схемы к другим приложениям, например, к zsh
if [ -f "$HOME/.cache/wal/colors.zsh" ]; then
    source "$HOME/.cache/wal/colors.zsh"
fi

# Применение цветовой схемы к Hyprland
# Пример: если у вас есть файл hyprland.conf с цветовыми настройками
if [ -f "$HOME/.cache/wal/colors-hyprland.conf" ]; then
    ln -sf "$HOME/.cache/wal/colors-hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
fi
