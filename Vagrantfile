# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

servers = [
    {
        :name => "k8s-client",
        :type => "client",
        :box => "ubuntu/bionic64",
        :eth1 => "192.168.50.81",
        :mem => "2048",
        :cpu => "2"
    }
]

$configureBox = <<-SCRIPT
    
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common curl
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
    cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
    deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
    curl -L https://git.io/get_helm.sh | bash
    apt-get update && apt-get install -y docker-ce python-pip bash-completion kubectl
    # run docker commands as vagrant user (sudo not required)
    usermod -aG docker vagrant
    
    echo "source <(kubectl completion bash)" >> ~/.bashrc
    echo 'alias k=kubectl'  >> ~/.bashrc
    echo 'complete -F __start_kubectl k'  >> ~/.bashrc
    sudo pip install -r /vagrant/ansible/requirements.txt
    
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/bionic64"
  # If you run into issues with Ansible complaining about executable permissions,
  # comment the following statement and uncomment the next one.
  #config.vm.synced_folder ".", "/vagrant"
  config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"]
  config.vm.synced_folder "C:/Users/jijeesh/.kube", "/home/vagrant/.kube", mount_options: ["dmode=700,fmode=600"]
  config.vm.synced_folder "E:/codes", "/vagrant/codes", mount_options: ["dmode=700,fmode=600"]  
  config.vm.provider "virtualbox" do |v|
    v.memory = 1048
  end
  config.vm.define :docker, primary: true do |docker|
    docker.vm.network :forwarded_port, host: 90, guest: 8080
    docker.vm.network :forwarded_port, host: 2203, guest: 22, id: "ssh", auto_correct: true
    docker.vm.network "private_network", ip: "192.168.50.81"
    config.vm.provision "shell", inline: $configureBox
    # docker.vm.provision "shell", path: "bootstrap.sh"
    # docker.vm.provision :shell, inline: 'ansible-playbook /vagrant/ansible/docker.yml -c local -v'
    docker.vm.hostname = "k8s-client"
  end

end
