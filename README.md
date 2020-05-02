## Kubernetes Using Ansible and Vagrant

 A multi node Kubernetes cluster for development purposes using Vagrant and Ansible.      


https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/


| Host Name      | IP Address        |Use                                         |
| ---------------|:------------------|:-------------------------------------------|
| ansible        | 192.168.50.5      |Ansible Control Workstation                 |
| k8s-master     | 192.168.50.10     |Kubernetes Master                           |
| k8s-node-1     | 192.168.50.11     |Kubernetes Worker Node 1                    |
| k8s-node-2     | 192.168.50.12     |Kubernetes Worker Node 2                    |
| k8s-node-3     | 192.168.50.13     |Kubernetes Worker Node 3                    |
## Prerequisites

VirtualBox v6.0  
https://www.virtualbox.org/wiki/Download_Old_Builds_6_0

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
```
## NOTE: In case setup fails to perform any certain function while pipeline runs due to some techical issue for eg (network connection). Use

```
vagrant provision
```
