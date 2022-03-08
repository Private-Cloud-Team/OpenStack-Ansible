#!/bin/bash
dnf upgrade -y
dnf install chrony openssh-server sudo -y
dnf group install "Development Tools" -y
dnf install curl nc python38 python38-devel libselinux-python3 systemd-devel openssl-devel libffi-devel rsync wget -y
systemctl stop firewalld
systemctl mask firewalld
mkdir /root/.ssh
chmod 700 /root/.ssh
ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
echo "CheckHostIP no" > /root/.ssh/config
echo "StrictHostKeyChecking no" >> /root/.ssh/config
cp /root/.ssh/* /home/vagrant/.ssh/
chown -R vagrant:vagrant /home/vagrant/.ssh
