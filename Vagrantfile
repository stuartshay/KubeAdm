# -*- mode: ruby -*-
# vi: set ft=ruby :

IMAGE_NAME = "bento/ubuntu-18.04"
N = 1


Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
      #Global settings for each virtual machine
      v.memory = 2048
      v.cpus = 2
      #v.gui = true
    end


    config.vm.define "k8s-master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network "private_network", ip: "192.168.50.10"
        master.vm.hostname = "k8s-master"

        master.vm.provider "virtualbox" do |vmvm|
          vmvm.memory = 2048
        end

        master.vm.provision "shell", path: "provision/base-provision.sh", privileged: true

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
          node.vm.provision "shell", path: "provision/base-provision.sh", privileged: true

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

    config.vm.define "nfs-server" do |nfs|
      nfs.vm.box = IMAGE_NAME
      nfs.vm.hostname = "nfs-server.example.com"
      nfs.vm.network "private_network", ip: "192.168.50.100"

      #nfs.vm.synced_folder "nfs-share/", "/srv/nfs/kubedata", type: "nfs"
      nfs.vm.synced_folder "provision/docker/", "/docker"
      nfs.vm.synced_folder "playbooks/", "/playbooks"

      nfs.vm.provider "virtualbox" do |n|
        n.name = "nfs-server"
        n.memory = 512
        n.cpus = 1
      end

      nfs.vm.provision "shell", path: "provision/base-provision.sh", privileged: true
      nfs.vm.provision "shell",path: "provision/nfs-provision.sh"

      nfs.vm.provision "shell" do |s|
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

    config.vm.define "ansible" do |ansible|
        ansible.vm.box = IMAGE_NAME
        ansible.vm.network "private_network", ip: "192.168.50.5"
        ansible.vm.hostname = "ansible"

        ansible.vm.provision "shell", path: "provision/base-provision.sh", privileged: true
        ansible.vm.provision  :shell, path: "provision/ansible-install.sh"
        ansible.vm.provision  :shell, inline: "cp /vagrant/ansible.cfg /etc/ansible/ansible.cfg"
        ansible.vm.provision  :shell, inline: "cp /vagrant/hosts /etc/ansible/hosts"

        ansible.vm.synced_folder "playbooks/", "/playbooks"
        ansible.vm.synced_folder "provision/helm", "/helm"
        ansible.vm.synced_folder "kube-config/", "/kube-config"

        ansible.vm.provider "virtualbox" do |vmvm|
          vmvm.memory = 512
        end

        ansible.trigger.after :up do |trigger|
          trigger.warn = "Starting minio containers"
          trigger.run_remote = {inline: "ansible-playbook /playbooks/roles/nfs-swarm-deploy.yml --limit nfs-server" ,privileged: false}
        end

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

        $script0 = <<-SCRIPT
        ansible-playbook /playbooks/roles/k8s-master.yml  --extra-vars "node_ip=192.168.50.10"
        SCRIPT
        ansible.vm.provision "shell", inline: $script0, privileged: false

        $script = <<-SCRIPT
        START=1
        END=$1
        for (( i=$START; i<=$END; i++ ))
        do
        	let a=10
        	let sum=$((a + i))
        ansible-playbook /playbooks/roles/k8s-node.yml --limit "k8s-node-$i"  --extra-vars "node_ip=192.168.50.$sum"
        done
        SCRIPT
        ansible.vm.provision "shell" do |shell|
        shell.inline = $script
        shell.privileged = false
        shell.args= N
        end

        $script2 = <<-SCRIPT
        scp vagrant@192.168.50.10://home/vagrant/.kube/config  ../../kube-config/
        SCRIPT
        ansible.vm.provision "shell", inline: $script2, privileged: false

        $script3 = <<-SCRIPT
        ansible-playbook /playbooks/roles/nfs.yml --limit "nfs-server"
        SCRIPT
        ansible.vm.provision "shell", inline: $script3, privileged: false

        $script4 = <<-SCRIPT
        ansible-playbook /playbooks/roles/ansible.yml --limit "ansible"
        SCRIPT
        ansible.vm.provision "shell", inline: $script4, privileged: false

        $script5 = <<-SCRIPT
        ansible-playbook /playbooks/roles/k8s-configuration.yml --limit "ansible"
        SCRIPT
        ansible.vm.provision "shell", inline: $script5, privileged: false

        $script6 = <<-SCRIPT
        ansible-playbook /playbooks/roles/k8s-storage.yml --limit "ansible"
        SCRIPT
        ansible.vm.provision "shell", inline: $script6, privileged: false

        $script7 = <<-SCRIPT
        ansible-playbook /playbooks/roles/k8s-components.yml --limit "ansible"
        SCRIPT
        ansible.vm.provision "shell", inline: $script7, privileged: false

    end


end
