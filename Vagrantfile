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
        ansible.vm.network "private_network", ip: "192.168.50.5"
        ansible.vm.hostname = "ansible"
        ansible.vm.provision  :shell, path: "provision/ansible-install.sh"
        ansible.vm.provision  :shell, inline: "cp /vagrant/ansible.cfg /etc/ansible/ansible.cfg"
        ansible.vm.provision  :shell, inline: "cp /vagrant/hosts /etc/ansible/hosts"
        
        
        ansible.vm.synced_folder "inventory/", "/inventory"
        ansible.vm.synced_folder "playbooks/", "/playbooks"
               
        ansible.vm.provision "shell" do |s|
            ssh_prv_key = ""
            ssh_pub_key = ""
            if File.file?("#{Dir.home}/.ssh/id_rsa")
              ssh_prv_key = File.read("#{Dir.home}/.ssh/id_rsa")
              ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
            else
              puts "No SSH key found. You will need to remedy this before pushing to the repository."
            end
            s.inline = <<-SHELL
              if grep -sq "#{ssh_pub_key}" /home/vagrant/.ssh/authorized_keys; then
                echo "SSH keys already provisioned."
                exit 0;
              fi
              echo "SSH key provisioning."
              mkdir -p /home/vagrant/.ssh/
              touch /home/vagrant/.ssh/authorized_keys
              echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
              echo #{ssh_pub_key} > /home/vagrant/.ssh/id_rsa.pub
              chmod 644 /home/vagrant/.ssh/id_rsa.pub
              echo "#{ssh_prv_key}" > /home/vagrant/.ssh/id_rsa
              chmod 600 /home/vagrant/.ssh/id_rsa
              chown -R vagrant:vagrant /home/vagrant
              exit 0
            SHELL
          end

    end

    config.vm.define "k8s-master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network "private_network", ip: "192.168.50.10"
        master.vm.hostname = "k8s-master"

        master.vm.provision "shell" do |s|
            ssh_prv_key = ""
            ssh_pub_key = ""
            if File.file?("#{Dir.home}/.ssh/id_rsa")
              ssh_prv_key = File.read("#{Dir.home}/.ssh/id_rsa")
              ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
            else
              puts "No SSH key found. You will need to remedy this before pushing to the repository."
            end
            s.inline = <<-SHELL
              if grep -sq "#{ssh_pub_key}" /home/vagrant/.ssh/authorized_keys; then
                echo "SSH keys already provisioned."
                exit 0;
              fi
              echo "SSH key provisioning."
              mkdir -p /home/vagrant/.ssh/
              touch /home/vagrant/.ssh/authorized_keys
              echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
              echo #{ssh_pub_key} > /home/vagrant/.ssh/id_rsa.pub
              chmod 644 /home/vagrant/.ssh/id_rsa.pub
              echo "#{ssh_prv_key}" > /home/vagrant/.ssh/id_rsa
              chmod 600 /home/vagrant/.ssh/id_rsa
              chown -R vagrant:vagrant /home/vagrant
              exit 0
            SHELL
          end
    end

    (1..N).each do |i|
       config.vm.define "k8s-node-#{i}" do |node|
          node.vm.box = IMAGE_NAME
          node.vm.network "private_network", ip: "192.168.50.#{i + 10}"
          node.vm.hostname = "node-#{i}"
            
          node.vm.provision "shell" do |s|
            ssh_prv_key = ""
            ssh_pub_key = ""
            if File.file?("#{Dir.home}/.ssh/id_rsa")
                ssh_prv_key = File.read("#{Dir.home}/.ssh/id_rsa")
                ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
            else
                puts "No SSH key found. You will need to remedy this before pushing to the repository."
            end
            s.inline = <<-SHELL
            
            if grep -sq "#{ssh_pub_key}" /home/vagrant/.ssh/authorized_keys; then
                echo "SSH keys already provisioned."
                exit 0;
            fi
                echo "SSH key provisioning."
                mkdir -p /home/vagrant/.ssh/
                touch /home/vagrant/.ssh/authorized_keys
                echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
                echo #{ssh_pub_key} > /home/vagrant/.ssh/id_rsa.pub
                chmod 644 /home/vagrant/.ssh/id_rsa.pub
                echo "#{ssh_prv_key}" > /home/vagrant/.ssh/id_rsa
                chmod 600 /home/vagrant/.ssh/id_rsa
                chown -R vagrant:vagrant /home/vagrant
                exit 0
            SHELL
            end

        end
    end

end