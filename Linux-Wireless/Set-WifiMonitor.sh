#!/bin/bash
# example_
# ./Set-WifiMonitor.sh wlan0 6
sudo iw reg set BZ
sudo ifconfig $1 down
sudo iw dev $1 set txpower fixed 30mBm
sudo iw $1 set type monitor
sudo ifconfig $1 up
sudo iw $1 set channel $2
sudo iw dev $1 set power_save off
sudo iw dev
