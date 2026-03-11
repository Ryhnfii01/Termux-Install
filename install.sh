#!/usr/bin/env bash

clear
echo "================================="
echo " Roblox APK Installer"
echo "================================="

pkg update -y >/dev/null 2>&1
pkg install curl wget -y >/dev/null 2>&1

REPO="Ryhnfii01/RobloxAPK"
TAG="APK"

DIR="/sdcard/Download/APK"

mkdir -p "$DIR"

echo ""
echo "Mengambil daftar APK dari GitHub..."

APK_LIST=($(curl -s https://api.github.com/repos/$REPO/releases/tags/$TAG \
| grep browser_download_url \
| grep ".apk" \
| cut -d '"' -f 4))

if [ ${#APK_LIST[@]} -eq 0 ]; then
    echo "Tidak ada APK ditemukan."
    exit 1
fi

echo ""
echo "APK yang tersedia:"
echo "-------------------"

i=1
for url in "${APK_LIST[@]}"; do
    name=$(basename "$url")
    echo "$i) $name"
    ((i++))
done

echo ""
read -p "Masukkan nomor APK yang ingin diinstall (contoh: 1 3): " choices

echo ""
echo "Menghapus APK lama..."
rm -f "$DIR"/*.apk

echo ""

for num in $choices; do
    url=${APK_LIST[$((num-1))]}
    file=$(basename "$url")

    echo "Downloading $file"
    wget --show-progress -O "$DIR/$file" "$url"

    echo "Installing $file"
    su -c "pm install -r -d '$DIR/$file'"
done

echo ""
echo "================================="
echo " Install selesai"
echo "================================="
