#!/bin/bash

passwd vagrant << EOF
vagrant
vagrant
EOF

apt-get update -y
apt-get dist-upgrade -y
