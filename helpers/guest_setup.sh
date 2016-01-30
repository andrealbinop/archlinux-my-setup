#!/bin/bash


set -e
pacman -Sy --noconfirm ansible
mkdir archlinux-my-setup && cd archlinux-my-setup
wget ${HOST}/archlinux-my-setup.tar.gz
tar -xzf archlinux-my-setup.tar.gz && rm -rf archlinux-my-setup.tar.gz
echo "sed -i 's/ConditionVirtualization=oracle/ConditionVirtualization=kvm/g' /usr/lib/systemd/system/vboxservice.service" >> post_install.sh
echo "mkdir /home/vagrant/.ssh && wget -O - https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub > /home/vagrant/.ssh/authorized_keys" >> post_install.sh
./setup.sh
