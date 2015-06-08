#/bin/bash

ANSIBLE_HOSTS=ansible/resources/hosts
SCRIPTS_DIR=$(readlink -m "$(dirname $0)")
export INSTALL_DIR=/$(basename $SCRIPTS_DIR)
CHROOT_BASE_DIR=/mnt

echo 'starting installation...'

if [ ! -f $CHROOT_BASE_DIR/bin/bash ]; then
  # runs ansible pre_install script
  echo 'configuring disks and installing base system...'
  ansible-playbook -i $ANSIBLE_HOSTS $SCRIPTS_DIR/ansible/pre_setup.yml
fi

if [  $? == 0 ]; then
  rm -rf $CHROOT_BASE_DIR$INSTALL_DIR
  cp -R $SCRIPTS_DIR $CHROOT_BASE_DIR$INSTALL_DIR
  # runs ansible install script while chrooted
  echo 'configuring base system...'
  arch-chroot $CHROOT_BASE_DIR ansible-playbook -i $INSTALL_DIR/$ANSIBLE_HOSTS $INSTALL_DIR/ansible/setup.yml

  if [  $? == 0 ]; then
    echo 'installation finished successfully, rebooting...'
    umount --recursive $CHROOT_BASE_DIR
    reboot
    exit 0
  fi
fi
