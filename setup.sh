#/bin/zsh

ANSIBLE_EXEC='ansible-playbook -c local'

ansible &>/dev/null
if [ $? != 1 ]; then
    ln -s /usr/bin/python2 /usr/bin/python
    pacman -Sy --noconfirm ansible
fi

# runs ansible with
$ANSIBLE_EXEC -i "localhost," ansible/pre_install.yml
