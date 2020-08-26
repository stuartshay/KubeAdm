#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
# Prerequisites
apt-get update -y
apt-get upgrade -y
apt-get install  apt-transport-https python3-pip dos2unix jq tree -y

# Install NFS Client
sudo apt-get install nfs-common

# Python 3 Default
update-alternatives --install /usr/bin/python python /usr/bin/python3 10

## Alias
cat > /home/vagrant/.bashrc <<END
  alias python=python3
  alias pip=pip3
  alias ls='ls -la'
END
sudo apt-get remove -y python3-requests
sudo -H pip3 install requests

## Ansible
apt-add-repository -y ppa:ansible/ansible
apt-get update -y
apt-get install -y ansible

pip3 install ansible-lint
echo "#############Installing k8s modules#############"
sudo -H pip3 install kubernetes
sudo -H pip3 install openshift
