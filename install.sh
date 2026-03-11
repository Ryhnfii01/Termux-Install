#!/data/data/com.termux/files/usr/bin/bash

clear
echo "================================="
echo " Roblox APK Auto Installer"
echo "================================="

pkg update -y >/dev/null 2>&1
pkg install curl wget -y >/dev/null 2>&1

REPO="Ryhnfii01/RobloxAPK"
TAG="APK"

echo ""
echo "Membersihkan file lama..."
rm -f *.apk

echo ""
echo "Mencari semua APK di GitHub Release..."

APK_URLS=$(curl -s https://api.github.com/repos/$REPO/releases/tags/$TAG | grep browser_download_url | grep ".apk" | cut -d '"' -f 4)

echo ""
echo "Downloading APK..."

for url in $APK_URLS
do
    file=$(basename "$url")
    echo "Downloading $file"
    wget "$url"
done

echo ""
echo "Installing APK..."

for apk in *.apk
do
    echo "Install $apk"
    pm install -r -d "$apk"
done

echo ""
echo "================================="
echo " Semua APK berhasil diinstall"
echo "================================="
