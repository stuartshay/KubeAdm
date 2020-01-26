#!/bin/bash

# Prerequisites
apt update -y
apt install  apt-transport-https dos2unix jq tree -y

## Alias 
cat > /home/vagrant/.bashrc <<END
  alias python=python3
END

## Ansible
apt-add-repository -y ppa:ansible/ansible
apt update -y
apt install -y ansible

pip install argcomplete
activate-global-python-argcomplete