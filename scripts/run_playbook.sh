#!/bin/bash
cd /vagrant/playbooks
ansible-galaxy install -r requirements.yml -p ./roles
ansible-galaxy install -r collection-requirements.yml
#ansible-playbook -i hosts.ini -u vagrant install_openstack.yml
