#!/usr/bin/env bash

# Update Repositories

# Add Ansible Repository & Install Ansible
sudo add-apt-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y software-properties-common ansible git

cat /vagrant/files/authorized_keys >> /home/vagrant/.ssh/authorized_keys

case $2 in
web)
    echo 'Setting up WEB environment'
    cp /vagrant/inventories/web /etc/ansible/hosts -f
    sudo ansible-galaxy install -r /vagrant/web/roles.yml
    sudo ansible-playbook /vagrant/web/playbook.yml -e hostname=$1 --connection=local -v
    ;;
db)
    echo 'Setting up DB environment'
    cp /vagrant/inventories/db /etc/ansible/hosts -f
    sudo ansible-galaxy install -r /vagrant/db/roles.yml
    sudo ansible-playbook /vagrant/db/playbook.yml -e hostname=$1 --connection=local -v
    ;;
doi)
    echo 'Setting up Digital Ocean environment'
    cp /vagrant/inventories/doi /etc/ansible/hosts -f
    sudo ansible-galaxy install -r /vagrant/doi/roles.yml
    sudo ansible-playbook /vagrant/doi/playbook.yml -e hostname=$1 --connection=local -v
    ;;
esac

# Setup Ansible for Local Use and Run
chmod 666 /etc/ansible/hosts



# sudo ansible-playbook /vagrant/playbook.yml -e hostname=fopsy.lan --connection=local -v
# .bashrc
# PATH="$PATH:/usr/local/lib/npm/bin"
