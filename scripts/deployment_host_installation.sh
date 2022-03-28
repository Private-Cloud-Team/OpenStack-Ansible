#!/bin/bash

## Install additional software packages if they were not installed during the operating system installation ##
apt-get install build-essential git chrony openssh-server python3-dev python3-pip sudo sshpass -y

## Install Ansible ##
pip3 install ansible

## Needed after installation ##
pip3 install python-openstackclient

## to check after if is still needed ##
cp /usr/local/bin/openstack /usr/bin/

## Generate SSH keys and configs ##
mkdir /root/.ssh
chmod 700 /root/.ssh
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
echo "CheckHostIP no" > /root/.ssh/config
echo "StrictHostKeyChecking no" >> /root/.ssh/config
cp /root/.ssh/* /home/vagrant/.ssh/
chown -R vagrant:vagrant /home/vagrant/.ssh
cp /ansible/hosts /etc/hosts
systemctl restart ssh.service
