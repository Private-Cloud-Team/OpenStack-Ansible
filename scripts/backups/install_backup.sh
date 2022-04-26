#!/bin/bash
lvchange --refresh ubuntu-vg
echo "===Installing LVM Snapshot Restore & Backup Method==="
cp check.sh /root/check.sh
echo "Setting .bash_profile to run check.sh"
cat ~/.bashrc | grep "bash /root/check.sh" || echo "bash /root/check.sh" >> /root/.bashrc
echo "Set size of LVM snapshot (example: 20G):"
read size
echo "Creating LVM Snapshot..."
lvcreate -L $size -s -n snap /dev/ubuntu-vg/ubuntu-lv
check=$(echo $?)
if [ $check != 0 ];then
    echo -e '\033[31mAn error occurs. \033[0m'
    exit
fi
cp backup.sh /root/backup.sh
echo "Setting up crontab..."
echo "@reboot touch /root/itsnotok;sleep 600;bash /root/backup.sh >> ~/logs" | crontab -
echo "LVM Snapshot creation finished"
