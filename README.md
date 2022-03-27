# OpenStack-Ansible

## Installation
```bash
vagrant plugin install vagrant-disksize
vagrant up
```

## Get Admin Password
```bash
$ vagrant ssh DeploymentHost
[vagrant@DeploymentHost ~]$ su
Password: vagrant
[root@DeploymentHost vagrant]$ cat /etc/openstack_deploy/user_secrets.yml | grep keystone_auth_admin_password
keystone_auth_admin_password: REDACTED
```

## Horizon Dashboard
link : https://192.168.56.10/  
user : admin  
password : {{ keystone_auth_admin_password }}  

## ISSUES
If you get the following error: "Could not find a controller named 'IDE'"  
This is not a Vagrant issue.  
The issue relies on Virtualbox use different Controller names between os.  

In some OS can be 'IDE Controller' but in other is just 'IDE'  
Try to change in the first line in Vagrantfile 'IDE' by 'IDE Controller'  

Or use these commands to check out what controller name virtualbox use in you os:  
```bash
$ VBoxManage list vms  
"c7_host01_1481400784099_26895" {97bec202-de3a-4b06-b790-4aa742671dd0}  
$ VBoxManage showvminfo 97bec202-de3a-4b06-b790-4aa742671dd0 | grep 'Storage Controller Name'  
Storage Controller Name (0):            IDE  
$ 
```
Then open Vagrantfile and change in the first line 'IDE' by the storage controller name you got.
