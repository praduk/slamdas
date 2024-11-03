#!/bin/bash
adb -d tcpip 5555
flutter build apk --release --shrink
ip=$(adb -d shell ip addr show wlan0 | grep 'inet ' | xargs echo | cut -f2 -d' ' | cut -f1 -d'/')
echo $ip
adb -d connect $ip:5555
adb -s $ip:5555 install -r ./build/app/outputs/flutter-apk/app-release.apk
