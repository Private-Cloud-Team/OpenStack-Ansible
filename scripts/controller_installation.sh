#!/bin/bash
## bridge-utils needed by Neutron ##
dnf install epel-release -y
dnf install bridge-utils -y
dnf install cloud-utils-growpart -y
growpart /dev/sda 1
xfs_growfs /
