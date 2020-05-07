#!/bin/bash

# update apt source
sudo -s -- <<EOF
apt-get update
apt-get upgrade -y
EOF

# install Dependencies
sudo apt-get install -y apt-transport-https ca-certificates curl

# Python 3 Default
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# install Python/pip
sudo apt -y install python3-pip
echo "alias python='python3'" >> /home/vagrant/.bashrc
echo "alias pip='pip3'" >> /home/vagrant/.bashrc
source ~/.bashrc