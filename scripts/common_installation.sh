#!/bin/bash
#dnf upgrade -y
sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config
mkdir /root/.ssh
chmod 700 /root/.ssh
