#!/bin/bash

PORT=${1:-5555}
TABLET_IP=`adb shell ip -f inet addr show wlan0 | grep inet | awk '{ print $2 }' | rev | cut -c 4- | rev`

echo "Setting up adb to run through tcpip @ $TABLET_IP:$PORT"

adb tcpip $PORT
adb connect $TABLET_IP:$PORT