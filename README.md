# Kubernetes Using Ansible and Vagrant

 A multi node Kubernetes cluster for development purposes using Vagrant and Ansible.      


https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/


| Host Name      | IP Address        |Use                                         |
| ---------------|:------------------|:-------------------------------------------|
| ansible        | 192.168.50.5      |Ansible Control Workstation                 |
| k8s-master     | 192.168.50.10     |Kubernetes Master                           |
| k8s-node-1     | 192.168.50.11     |Kubernetes Worker Node 1                    |
| k8s-node-2     | 192.168.50.12     |Kubernetes Worker Node 2                    |
| k8s-node-3     | 192.168.50.13     |Kubernetes Worker Node 3                    |
| nfs-server     | 192.168.50.100    |NFS Server                                  |

## Prerequisites

VirtualBox v6.1  
https://www.virtualbox.org/wiki/Downloads

Vagrant 2.2.9    
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
vagrant box update
vagrant up
```

Reprovisioning of the vagrant machine
```
vagrant provision
```
## Access Kubernetes dashboard
Step 1. Run
```bash
kubectl proxy
```
Step 2. Goto browser
```bash
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/.
```
Step 3. Generate token and login
```bash
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
```
