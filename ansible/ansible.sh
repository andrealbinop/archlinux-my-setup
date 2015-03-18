#/bin/bash

SCRIPTS_DIR=$(readlink -m "$(dirname $0)")

ansible-playbook -vvv -c local $@
