#!/bin/bash

# Папка для установки
ALPINE_DIR="./root"

# Создаём папку, если её нет
mkdir -p "$ALPINE_DIR"

# Ссылка на архив
ALPINE_URL="https://dl-cdn.alpinelinux.org/alpine/v3.21/releases/x86_64/alpine-minirootfs-3.21.3-x86_64.tar.gz"
ARCHIVE_NAME="alpine-minirootfs-3.21.3-x86_64.tar.gz"

# Проверяем, скачан ли архив
if [ -f "$ARCHIVE_NAME" ]; then
    echo "Система уже скачана."
else
    echo "Скачиваем Alpine Linux..."
    curl -O "$ALPINE_URL"
fi

# Проверяем, распакована ли система
if [ -n "$(ls -A "$ALPINE_DIR" 2>/dev/null)" ]; then
    echo "Система уже распакована."
else
    echo "Распаковываем систему..."
    tar -xzvf "$ARCHIVE_NAME" -C "$ALPINE_DIR"
fi

# Запускаем Alpine через proot
echo "Запускаем Alpine..."
curl -LO https://proot.gitlab.io/proot/bin/proot
chmod +x ./proot
./proot -0 -r "$ALPINE_DIR" -b /dev -b /proc -b /sys -w /root /bin/sh