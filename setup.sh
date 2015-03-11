#/bin/bash

ANSIBLE_EXEC="ansible-playbook -c local"
ANSIBLE_HOSTS=/etc/ansible/hosts
SCRIPTS_DIR=$(readlink -m "$(dirname $0)")
INSTALL_DIR=/mnt

# installs and configure ansible
ansible &>/dev/null
if [ $? != 1 ]; then
  pacman -Sy --noconfirm ansible
  echo "localhost" > $ANSIBLE_HOSTS
fi

# runs pre install steps
if [ ! -f "$INSTALL_DIR/bin/bash" ]; then
  # runs ansible pre_install script
  $ANSIBLE_EXEC ansible/pre_install.yml --extra-vars "install_dir=$INSTALL_DIR"
fi

# makes script files and ansible available to chroot environment
CHROOT_SCRIPTS_DIR="$INSTALL_DIR$SCRIPTS_DIR"
if [ ! -d "$CHROOT_SCRIPTS_DIR" ]; then
  mkdir -p $CHROOT_SCRIPTS_DIR
  mount --bind $SCRIPTS_DIR $CHROOT_SCRIPTS_DIR
  mount -o remount,ro $CHROOT_SCRIPTS_DIR
  echo "localhost" > "$INSTALL_DIR$ANSIBLE_HOSTS"
fi

# runs ansible install script while chrooted
arch-chroot $INSTALL_DIR $ANSIBLE_EXEC $SCRIPTS_DIR/ansible/install.yml
