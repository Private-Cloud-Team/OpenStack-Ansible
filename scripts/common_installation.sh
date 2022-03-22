#!/bin/bash
#dnf upgrade -y
sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
mkdir /root/.ssh
chmod 700 /root/.ssh
