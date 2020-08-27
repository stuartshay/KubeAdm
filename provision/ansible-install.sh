#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
sudo dpkg-reconfigure debconf -f noninteractive -p critical
# Prerequisites
apt-get update -y 2> /dev/null 

apt-get upgrade -y 2> /dev/null 

apt-get install  apt-transport-https python3-pip dos2unix jq tree -y 2> /dev/null 

# Install NFS Client
sudo apt-get install nfs-common 2> /dev/null 

# Python 3 Default
update-alternatives --install /usr/bin/python python /usr/bin/python3 10 2> /dev/null 

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
apt-get update -y 2> /dev/null 
apt-get install -y ansible 2> /dev/null 

pip3 install ansible-lint
echo "#############Installing k8s modules#############"
sudo -H pip3 install kubernetes
sudo -H pip3 install openshift
