#!/bin/bash
adb -d pull /storage/3963-6363/Download/daq ./sdcard
adb -d shell rm -r /storage/3963-6363/Download/daq
