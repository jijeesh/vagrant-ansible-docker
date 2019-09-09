# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/bionic64"
  # If you run into issues with Ansible complaining about executable permissions,
  # comment the following statement and uncomment the next one.
  #config.vm.synced_folder ".", "/vagrant"
  config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"]
  config.vm.synced_folder "C:/Users/jijeesh/.kube", "/home/vagrant/.kube", mount_options: ["dmode=700,fmode=600"]  
  config.vm.provider "virtualbox" do |v|
    v.memory = 1048
  end
  config.vm.define :docker, primary: true do |docker|
    docker.vm.network :forwarded_port, host: 90, guest: 8080
    docker.vm.network :forwarded_port, host: 2203, guest: 22, id: "ssh", auto_correct: true
    docker.vm.network "private_network", ip: "192.168.50.81"
    docker.vm.provision "shell", path: "bootstrap.sh"
    docker.vm.provision :shell, inline: 'ansible-playbook /vagrant/ansible/docker.yml -c local -v'
    docker.vm.hostname = "docker"
  end

end
