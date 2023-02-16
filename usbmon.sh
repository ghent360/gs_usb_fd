#!/bin/sh
sudo modprobe usbmon
sudo setfacl -m u:vne:r /dev/usbmon*
