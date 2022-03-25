#!/bin/bash
## kmod-devel nedeed by Cinder ##
dnf --enablerepo=powertools install kmod-devel -y

## Storage Configuration
dnf install lvm2 -y
pvcreate --metadatasize 2048 /dev/sdb
vgcreate cinder-volumes /dev/sdb

