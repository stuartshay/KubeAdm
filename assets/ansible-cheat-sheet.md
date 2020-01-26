
## Common Ansible Commands


### Config

```
vagrant ssh-config
ansible-config --version
```

### Inventory

```
ansible-inventory --graph

ansible all --list-hosts -- list all hosts in hosts file
ansible <group_name> --list-hosts  --list hosts by group
```






### Files & Folders

```
ansible <group_name> -m setup --tree ~/.ansible/tmp/facts -k -u <userid>` --write to file 
```

### Facts 

```
ansible <group_name> -i hosts -m setup -k -u <userid> --get facts 
ansible <group_name> -m setup -a 'filter=*ipv4*' -k -u <userid>` --filter facts 
```

```bash
sudo ansible nodeweb -i hosts -m setup -k  -u vagrant
sudo ansible nodeweb -m setup -a 'filter=*ipv4*' -k  -u vagrant
sudo ansible nodeweb -m setup --tree ~/.ansible/tmp/facts -k -u vagrant
```

- `ansible <group_name> -m file -a 'path=<filename-path>' -k -u <userid> ` --check file exists
- `ansible <group_name> -m file -a 'path=<directory-path> state=directory mode=0700 owner=root' -k -s -u <userid>`-- create directory


```bash
sudo ansible nodeweb -m file -a 'path=/etc/fstab' -k  -u vagrant
sudo ansible nodeweb -m file -a 'path=/tmp/etc/ state=directory mode=1755 owner=root' -k -s -u vagrant
```
### Linux Ping

- `ansible all -m ping -s -k -u vagrant`




