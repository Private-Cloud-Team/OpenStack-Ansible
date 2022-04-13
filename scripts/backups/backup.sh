#!/bin/bash
ls /root/itsnotok && echo "Restoring server and rebooting..."
ls /root/itsnotok && /usr/sbin/lvconvert --merge /dev/ubuntu-vg/snap && /usr/sbin/reboot
