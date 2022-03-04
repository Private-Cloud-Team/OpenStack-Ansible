#!/bin/bash
dnf upgrade -y
dnf install git chrony openssh-server python3-devel sudo -y
dnf group install "Development Tools" -y
systemctl stop firewalld
systemctl mask firewalld
