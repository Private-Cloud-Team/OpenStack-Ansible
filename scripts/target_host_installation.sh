#!/bin/bash
#dnf upgrade -y
dnf install git -y
sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
mkdir /root/.ssh
chmod 700 /root/.ssh

## kmod-devel nedeed by Cinder ##
dnf --enablerepo=powertools install kmod-devel -y
