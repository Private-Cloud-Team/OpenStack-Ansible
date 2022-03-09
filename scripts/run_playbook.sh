#!/bin/bash
cd /vagrant/playbooks
ansible-playbook -i hosts.ini -u vagrant install_openstack.yml
