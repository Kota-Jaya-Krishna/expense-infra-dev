#!/bin/bash


dnf install ansible -y

# push type archetecture in Ansible #
# ansible-playbook -i inventory mysql.yaml #


# pull type archetecture in Ansible #

ansible-pull -i localhost, -U https://github.com/Kota-Jaya-Krishna/ansible-expense-roles-tf.git main.yaml -e COMPONENT=backend -e ENVIRONMENT=$1
