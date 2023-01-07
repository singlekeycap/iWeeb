#!/bin/bash
read -p "Enter version number: " version
xcodebuild -project iWeeb.xcodeproj -scheme iWeeb -sdk iphoneos -configuration Release CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=NO -derivedDataPath build

mkdir ml.singlekeycap.iweeb_${version}_iphoneos-arm
mkdir ml.singlekeycap.iweeb_${version}_iphoneos-arm/DEBIAN
mkdir ml.singlekeycap.iweeb_${version}_iphoneos-arm/Applications
cp -r build/Build/Products/Release-iphoneos/iWeeb.app ml.singlekeycap.iweeb_${version}_iphoneos-arm/Applications/
echo -e "Package: ml.singlekeycap.iweeb\nName: iWeeb\nIcon: https://repo.singlekeycap.ml/icons/iWeeb.png\nDepends: firmware (>= 14.0)\nArchitecture: iphoneos-arm\nDescription: Best weeb app for all weebs\nMaintainer: SingleKeycap\nAuthor: SingleKeycap\nSection: Applications\nVersion: ${version}\nInstalled-Size: $(du -ks ml.singlekeycap.iweeb_${version}_iphoneos-arm/Applications|cut -f 1)\n" > ml.singlekeycap.iweeb_${version}_iphoneos-arm/DEBIAN/control
chmod -R 0755 ml.singlekeycap.iweeb_${version}_iphoneos-arm/DEBIAN
dpkg-deb --build ml.singlekeycap.iweeb_${version}_iphoneos-arm

mkdir Payload
cp -r build/Build/Products/Release-iphoneos/iWeeb.app Payload/
zip -r iWeeb_${version}.ipa Payload

rm -rf build Payload ml.singlekeycap.iweeb_${version}_iphoneos-arm
