#!/bin/bash

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
192.168.50.100 nfs-server.example.com nfs-server
192.168.50.101 nginx-server-1
192.168.50.102 nginx-server-2
192.168.50.103 nginx-server-3
192.168.50.104 nginx-server-4
192.168.50.105 nginx-server-5
192.168.50.10 k8s-master
192.168.50.11 k8s-node-1
192.168.50.12 k8s-node-2
192.168.50.13 k8s-node-3
192.168.50.5  ansible 
EOF

# apt-cacher-ng
#echo Acquire::http::Proxy \"http://192.168.33.10:3142\"\; | sudo tee /etc/apt/apt.conf.d/00proxy

# Update apt source
sudo -s -- <<EOF
apt-get update 
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y 
EOF

# Install Dependencies
sudo apt-get install -y apt-transport-https ca-certificates curl

# Install NFS Client
sudo apt install nfs-common

# Python 3 Default
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# install Python/pip
sudo apt -y install python3-pip
echo "alias python='python3'" >> /home/vagrant/.bashrc
echo "alias pip='pip3'" >> /home/vagrant/.bashrc
source ~/.bashrc
