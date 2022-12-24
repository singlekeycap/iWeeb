#!/bin/bash
xcodebuild archive -project iWeeb.xcodeproj -scheme iWeeb -archivePath unsigned.xarchive -configuration Release CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=NO
mv unsigned.xarchive/Products/Applications Payload
zip -r iWeeb.ipa Payload
rm -r unsigned.xarchive
