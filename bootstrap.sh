#!/bin/bash

echo "Installing Ansible..."
apt-get install -y software-properties-common
#apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install -y python-pip
sudo pip install -r requirements.txt
#cp /vagrant/ansible/ansible.cfg /etc/ansible/ansible.cfg