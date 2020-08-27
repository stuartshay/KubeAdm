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
export DEBIAN_FRONTEND=noninteractive
sudo dpkg-reconfigure debconf -f noninteractive -p critical
# Update apt source
sudo -s -- <<EOF
sudo DEBIAN_FRONTEND=noninteractive apt-get update  2> /dev/null 
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y  2> /dev/null 
EOF

# Install Dependencies
sudo apt-get install -y apt-transport-https ca-certificates curl 2> /dev/null 

# Install NFS Client
sudo apt-get install nfs-common 2> /dev/null 

# Python 3 Default
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10 2> /dev/null 

# install Python/pip
sudo apt-get -y install python3-pip 2> /dev/null 
echo "alias python='python3'" >> /home/vagrant/.bashrc
echo "alias pip='pip3'" >> /home/vagrant/.bashrc
source ~/.bashrc
