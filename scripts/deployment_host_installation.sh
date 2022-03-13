#!/bin/bash
#dnf upgrade -y
dnf install epel-release -y
dnf install ansible -y
pip3 install "openstacksdk>=0.36" "pymysql==0.9.3" "jmespath" "Jinja2==2.11" "netaddr"
systemctl stop firewalld
systemctl mask firewalld
mkdir /root/.ssh
chmod 700 /root/.ssh
ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
echo "CheckHostIP no" > /root/.ssh/config
echo "StrictHostKeyChecking no" >> /root/.ssh/config
cp /root/.ssh/* /home/vagrant/.ssh/
chown -R vagrant:vagrant /home/vagrant/.ssh
cp /vagrant/hosts /etc/hosts
