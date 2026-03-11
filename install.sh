#!/data/data/com.termux/files/usr/bin/bash

clear
echo "Roblox APK Auto Installer"

pkg install curl wget jq -y > /dev/null 2>&1

REPO="Ryhnfii01/RobloxAPK"
TAG="APK"

echo "Mencari APK di GitHub Release..."

APK_URLS=$(curl -s https://api.github.com/repos/$REPO/releases/tags/$TAG \
 | jq -r '.assets[] | select(.name | endswith(".apk")) | .browser_download_url')

echo "Downloading dan Installing..."

for url in $APK_URLS; do
    file=$(basename "$url")
    
    echo "Download $file"
    wget -q --show-progress "$url"
    
    echo "Install $file"
    pm install -r -d "$file"
done

echo "Selesai!"
