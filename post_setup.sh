#/bin/bash

SCRIPTS_DIR=$(readlink -m "$(dirname $0)")
ANSIBLE_HOSTS=$SCRIPTS_DIR/ansible/resources/hosts
ansible-playbook -i $ANSIBLE_HOSTS $SCRIPTS_DIR/ansible/post_setup.yml
