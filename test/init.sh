#!/bin/bash

SCRIPTS_DIR=$(readlink -m "$(dirname $0)")/..

pacman -Sy --noconfirm ansible dos2unix
systemctl enable sshd && systemctl start sshd
echo "Please set root password"
passwd

# allows development on a windows host
chmod +x $SCRIPTS_DIR/*.sh && dos2unix $SCRIPTS_DIR/*.sh
