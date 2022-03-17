#!/bin/bash
#dnf upgrade -y
dnf install git -y
sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
mkdir /root/.ssh
chmod 700 /root/.ssh

## bridge-utils needed by Neutron ##
dnf install epel-release -y
dnf install bridge-utils -y

## kmod-devel nedeed by Cinder ##
dnf --enablerepo=powertools install kmod-devel -y
