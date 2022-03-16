#!/bin/bash
#dnf upgrade -y
dnf install epel-release -y
dnf install ansible -y
pip3 install "openstacksdk==0.61.0" "pymysql==0.9.3" "jmespath==0.10.0" "Jinja2==3.0.3" "netaddr==0.8.0"
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
