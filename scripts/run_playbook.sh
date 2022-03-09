#!/bin/bash
cd /vagrant/playbooks
ansible-galaxy install -r requirements.yml -p ./roles
ansible-galaxy collection install community.general
ansible-playbook -i hosts.ini -u vagrant install_openstack.yml
