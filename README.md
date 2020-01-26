## Kubernetes Using Ansible and Vagrant


https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/

## Prerequisites

VirtualBox v6.0  
https://www.virtualbox.org/

Vagrant 2.2.6  
https://www.vagrantup.com/downloads.html

### Check Local SSH Keys

```
ls -la ~/.ssh | grep id_rsa

id_rsa
id_rsa.ppk
id_rsa.pub
```

## Setup

```
vagrant up
vagrant ssh ansible 
```

### Run the Setup Playbook
```
vagrant@ansible:$ cd /playbooks/setup
vagrant@ansible:$ ansible-playbook -i hosts setup.yml
```
