#!/bin/bash

## Install additional software packages ##
apt-get install bridge-utils debootstrap ifenslave ifenslave lsof lvm2 openssh-server sudo tcpdump vlan python3 -y

## SSH Configs ##
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
systemctl restart ssh.service
mkdir /root/.ssh
chmod 700 /root/.ssh
