# -*- mode: ruby -*-
# vi: set ft=ruby :

IMAGE_NAME = "bento/ubuntu-18.04"
N = 2


Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 2
    end
    
    
    config.vm.define "ansible" do |ansible|
        ansible.vm.box = IMAGE_NAME
        ansible.vm.network "private_network", ip: "192.168.50.1"
        ansible.vm.hostname = "ansible"
        ansible.vm.provision  :shell, path: "provision/ansible-install.sh"
        ansible.vm.provision  :shell, inline: "cp /vagrant/ansible.cfg /etc/ansible/ansible.cfg"
        ansible.vm.synced_folder "inventory/", "/inventory"
        ansible.vm.synced_folder "playbooks/", "/playbooks"

        ansible.ssh.forward_agent    = true
        ansible.ssh.insert_key       = false
        ansible.ssh.private_key_path =  ["~/.vagrant.d/insecure_private_key","~/.ssh/id_rsa"]
        ansible.vm.provision "shell" do |s|
            ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
            s.inline = <<-SHELL
              echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
            SHELL
        end

    end




    config.vm.define "k8s-master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network "private_network", ip: "192.168.50.10"
        master.vm.hostname = "k8s-master"

     #   master.ssh.insert_key = false
     #   master.ssh.private_key_path = ['~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa'] 
      ##  master.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys" 

        #master.vm.provision "ansible" do |ansible|
            #ansible.playbook = "kubernetes-setup/master-playbook.yml"
            #ansible.extra_vars = {
            #    node_ip: "192.168.50.10",
            #}
        #end
    end

    (1..N).each do |i|
       config.vm.define "node-#{i}" do |node|
          node.vm.box = IMAGE_NAME
          node.vm.network "private_network", ip: "192.168.50.#{i + 10}"
          node.vm.hostname = "node-#{i}"
            
            ## node.ssh.insert_key = false
          ## node.ssh.private_key_path = ['~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa'] 
          #  node.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys" 

            #node.vm.provision "ansible" do |ansible|
            #    ansible.playbook = "kubernetes-setup/node-playbook.yml"
            #    ansible.extra_vars = {
            #        node_ip: "192.168.50.#{i + 10}",
            #    }
            #end
        end
    end

end