#!/data/data/com.termux/files/usr/bin/bash

clear
echo "Roblox APK Installer"
echo "Downloading APK..."

pkg install wget -y > /dev/null 2>&1

wget -O roblox1.apk https://github.com/Ryhnfii01/RobloxAPK/releases/download/APK/Roniy.1-2.710.707.apk.apk
wget -O roblox2.apk https://github.com/Ryhnfii01/RobloxAPK/releases/download/APK/Roniy.2-2.710.707.apk.apk
wget -O roblox3.apk https://github.com/Ryhnfii01/RobloxAPK/releases/download/APK/Roniy.3-2.710.707.apk.apk
wget -O roblox4.apk https://github.com/Ryhnfii01/RobloxAPK/releases/download/APK/Roniy.4-2.710.707.apk.apk

echo "Installing..."

pm install -r roblox1.apk
pm install -r roblox2.apk
pm install -r roblox3.apk
pm install -r roblox4.apk

echo "Install selesai!"