#!/bin/bash
vagrant scp $1:~/.ssh/id_rsa.pub id_rsa.pub
for i in ${@: 2}; do
	vagrant ssh $i -c "echo `cat id_rsa.pub` >> /home/vagrant/.ssh/authorized_keys"
done
