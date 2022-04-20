#!/bin/bash
check=$(ls /root/itsnotok | wc -l | xargs)
if [ $check -eq 1 ];then
        echo "Do you want to remove itsnotok file? (y/n)"
        read a
        if [ "$a" = "y" ]; then
                rm -rf /root/itsnotok
	fi
fi
//TODO: check if the lvm snapshot named snap is exists and if not exists notify the user RED color.
