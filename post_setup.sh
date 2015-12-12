#!/bin/bash

export INSTALL_DIR=$(readlink -m "$(dirname $0)")
ANSIBLE_HOSTS=$INSTALL_DIR/ansible/resources/hosts

echo 'running post installation script...'
ansible-playbook -i $ANSIBLE_HOSTS $INSTALL_DIR/ansible/post_setup.yml
