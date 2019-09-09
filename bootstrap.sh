#!/bin/bash

echo "Installing Ansible..."
apt-get install -y software-properties-common curl
#apt-add-repository ppa:ansible/ansible
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
curl -L https://git.io/get_helm.sh | bash
apt-get update
apt-get install -y python-pip bash-completion kubectl
sudo pip install -r /vagrant/ansible/requirements.txt
#cp /vagrant/ansible/ansible.cfg /etc/ansible/ansible.cfg