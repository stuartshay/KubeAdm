## Kubernetes Using Ansible and Vagrant


https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/

## Prerequisites

VirtualBox v6.0
https://www.virtualbox.org/

Vagrant 2.2.6
https://www.vagrantup.com/downloads.html

### Check SSH Keys

```
ls -la ~/.ssh | grep id_rsa
```







## Setup

```
vagrant up
```












```
$ ## Accessing master
$ vagrant ssh k8s-master

vagrant@k8s-master:~$ kubectl get nodes
NAME         STATUS   ROLES    AGE     VERSION
k8s-master   Ready    master   18m     v1.13.3
node-1       Ready    <none>   12m     v1.13.3
node-2       Ready    <none>   6m22s   v1.13.3

$ ## Accessing nodes
$ vagrant ssh node-1
$ vagrant ssh node-2
```