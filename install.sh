#!/usr/bin/env bash

clear
echo "================================="
echo " Roblox APK Auto Installer"
echo "================================="

pkg update -y >/dev/null 2>&1
pkg install curl wget -y >/dev/null 2>&1

REPO="Ryhnfii01/RobloxAPK"
TAG="APK"

DIR="/sdcard/Download/APK"

echo ""
echo "Menyiapkan folder..."

mkdir -p "$DIR"

echo "Menghapus APK lama..."
rm -f "$DIR"/*.apk

echo ""
echo "Mencari semua APK di GitHub Release..."

APK_URLS=$(curl -s https://api.github.com/repos/$REPO/releases/tags/$TAG | grep browser_download_url | grep ".apk" | cut -d '"' -f 4)

if [ -z "$APK_URLS" ]; then
    echo "Tidak ada APK ditemukan di release."
    exit 1
fi

echo ""
echo "Downloading APK..."

for url in $APK_URLS; do
    file=$(basename "$url")
    echo "Downloading $file"
    wget --show-progress -O "$DIR/$file" "$url"
done

echo ""
echo "Installing APK..."

for apk in "$DIR"/*.apk; do
    if [ -f "$apk" ]; then
        name=$(basename "$apk")
        size=$(stat -c%s "$apk")

        echo "Install $name"
        cat "$apk" | pm install -r -d -S "$size"
    fi
done

echo ""
echo "================================="
echo " Semua APK berhasil diinstall"
echo "================================="
