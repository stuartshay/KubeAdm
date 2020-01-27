## Kubernetes Using Ansible and Vagrant

 A multi node Kubernetes cluster for development purposes using Vagrant and Ansible.      


https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/


| Host Name      | IP Address        |Use                                         |
| ---------------|:------------------|:-------------------------------------------|
| ansible        | 192.168.50.5      |Ansible Control Workstation                 |
| k8s-master     | 192.168.50.10     |Kubernetes Master                           |
| k8s-node-1     | 192.168.50.11     |Kubernetes Worker Node 1                    |
| k8s-node-2     | 192.168.50.12     |Kubernetes Worker Node 2                    |

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

# Connect to Ansible
vagrant ssh ansible 
```

### Run the Setup Playbook From Ansible Control Host
```
ansible-playbook -i /playbooks/setup/hosts /playbooks/setup/setup.yml
```
