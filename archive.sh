#!/bin/bash
read -p "Enter version number: " version
xcodebuild archive -project iWeeb.xcodeproj -scheme iWeeb -archivePath unsigned.xcarchive -configuration Release CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=NO

mkdir ml.singlekeycap.iweeb_${version}_iphoneos-arm
mkdir ml.singlekeycap.iweeb_${version}_iphoneos-arm/DEBIAN
cp -r unsigned.xcarchive/Products/Applications ml.singlekeycap.iweeb_${version}_iphoneos-arm/Applications
echo -e "Package: ml.singlekeycap.iweeb\nName: iWeeb\nDepends: firmware (>= 14.0)\nArchitecture: iphoneos-arm\nDescription: Best weeb app for all weebs\nMaintainer: SingleKeycap\nAuthor: SingleKeycap\nSection: Applications\nVersion: ${version}\nInstalled-Size: $(du -ks ml.singlekeycap.iweeb_${version}_iphoneos-arm/Applications|cut -f 1)\n" > ml.singlekeycap.iweeb_${version}_iphoneos-arm/DEBIAN/control
chmod -R 0755 ml.singlekeycap.iweeb_${version}_iphoneos-arm/DEBIAN
dpkg-deb --build ml.singlekeycap.iweeb_${version}_iphoneos-arm

mkdir Payload
cp -r unsigned.xcarchive/Products/Applications/iWeeb.app Payload/iWeeb.app
zip -r iWeeb_${version}.ipa Payload

rm -r unsigned.xcarchive Payload ml.singlekeycap.iweeb_${version}_iphoneos-arm
