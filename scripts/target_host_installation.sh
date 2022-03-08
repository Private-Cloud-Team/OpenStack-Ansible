#!/bin/bash
dnf upgrade -y
sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
dnf install iputils lsof openssh-server sudo tcpdump python3 -y
mkdir /root/.ssh
chmod 700 /root/.ssh
