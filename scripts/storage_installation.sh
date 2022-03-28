#!/bin/bash

## Storage Configuration
apt-get install lvm2 -y
pvcreate --metadatasize 2048 /dev/sdb
vgcreate cinder-volumes /dev/sdb

