#!/usr/bin/env bash

clear
echo "================================="
echo " Roblox APK Auto Installer"
echo "================================="

pkg update -y >/dev/null 2>&1
pkg install curl wget -y >/dev/null 2>&1

REPO="Ryhnfii01/RobloxAPK"
TAG="APK"

SD_DIR="/sdcard/Download/APK"
TMP_DIR="/data/local/tmp"

mkdir -p "$SD_DIR"

echo "Menghapus APK lama..."
rm -f "$SD_DIR"/*.apk

echo ""
echo "Mencari semua APK di GitHub Release..."

APK_URLS=$(curl -s https://api.github.com/repos/$REPO/releases/tags/$TAG | grep browser_download_url | grep ".apk" | cut -d '"' -f 4)

echo ""
echo "Downloading APK..."

for url in $APK_URLS; do
    file=$(basename "$url")
    echo "Downloading $file"
    wget --show-progress -O "$SD_DIR/$file" "$url"
done

echo ""
echo "Installing APK..."

for apk in "$SD_DIR"/*.apk; do
    if [ -f "$apk" ]; then
        name=$(basename "$apk")

        cp "$apk" "$TMP_DIR/$name"
        chmod 644 "$TMP_DIR/$name"

        echo "Install $name"
        cmd package install -r -d "$TMP_DIR/$name"
    fi
done

echo ""
echo "================================="
echo " Semua APK berhasil diinstall"
echo "================================="
