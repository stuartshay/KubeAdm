## Common Ansible Commands

- `ansible all --list-hosts` -- list all hosts in hosts file

- `ansible <group_name> --list-hosts`  --list hosts by group

- `ansible <group_name> -i hosts -m setup -k -u <userid>` --get facts 
- `ansible <group_name> -m setup -a 'filter=*ipv4*' -k -u <userid>` --filter facts 
- `ansible <group_name> -m setup --tree ~/.ansible/tmp/facts -k -u <userid>` --write to file 

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

### Windows Ping


## Playbooks

sudo ansible-playbook webserver.yml



## Links 
https://github.com/iJackUA/awesome-vagrant

http://neeleshgurjar.co.in/techidnyan/ansible-basics/

http://neeleshgurjar.co.in/techidnyan/install-ansible-2-x-and-manage-windows-machines/




## Tips
http://www.virtualtothecore.com/en/configuring-windows-machines-for-ansible/

https://www.gitbook.com/book/tumregels/ansible-tutorial/details     

https://github.com/leucos/ansible-tuto/tree/master/step-00       

https://serversforhackers.com/an-ansible-tutorial       


http://ermaker.github.io/blog/2015/11/18/change-insecure-key-to-my-own-key-on-vagrant.html

https://github.com/lowescott/learning-tools/tree/master/vagrant

https://github.com/geerlingguy/packer-ubuntu-1604