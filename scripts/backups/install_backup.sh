#!/bin/bash
echo "===Installing LVM Snapshot Restore & Backup Method==="
echo "Setting up crontab..."
echo "@reboot touch /root/itsnotok;sleep 300;bash /root/backup.sh >> ~/logs" | crontab -
echo "Set size of LVM snapshot (example: 20G):"
read size
echo "Creating LVM Snapshot..."
lvcreate -L $size -s -n snap /dev/ubuntu-vg/ubuntu-lv
echo "Setting backup.sh && check.sh..."
cp backup.sh /root/backup.sh
cp check.sh /root/check.sh
echo "Setting .bash_profile to run check.sh"
cat ~/.bashrc | grep "bash /root/check.sh" || echo "bash /root/check.sh" >> /root/.bashrc
echo "LVM Snapshot creation finished"
