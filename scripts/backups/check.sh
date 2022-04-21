#!/bin/bash
check=$(ls /root/itsnotok 2>/dev/null | wc -l | xargs)
to_check=$(lvdisplay | grep "Logical volume" | awk '{$1=$1};1' | wc -l)
if [ $check -eq 1 ];then
        echo "Do you want to remove itsnotok file? (y/n)"
        read a
        if [ "$a" = "y" ]; then
                rm -rf /root/itsnotok
	fi
fi
if [ $to_check -eq 2 ];then
        echo -e '\033[31m an error occurs. \033[0m'
fi
