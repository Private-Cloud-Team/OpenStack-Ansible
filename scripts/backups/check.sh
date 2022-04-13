#!/bin/bash
check=$(ls /root/itsnotok | wc -l | xargs)
if [ $check -eq 1 ];then
        echo "Is everything okay? (Y)"
        read a
        if [ "$a" = "Y" ]; then
                rm -rf /root/itsnotok
	fi
fi