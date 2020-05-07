#!/bin/bash

# Prerequisites
apt update -y
apt upgrade -y
apt install  apt-transport-https python3-pip dos2unix jq tree -y

# Python 3 Default
update-alternatives --install /usr/bin/python python /usr/bin/python3 10

## Alias 
cat > /home/vagrant/.bashrc <<END
  alias python=python3
  alias ls='ls -la'
END

## Ansible
apt-add-repository -y ppa:ansible/ansible
apt update -y
apt install -y ansible

#pip3 install argcomplete
#activate-global-python-argcomplete