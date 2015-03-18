#/bin/bash

ANSIBLE_HOSTS=ansible/resources/hosts
SCRIPTS_DIR=$(readlink -m "$(dirname $0)")
CHROOT_SCRIPTS_DIR=/$(basename $SCRIPTS_DIR)
INSTALL_DIR=/mnt

echo 'starting installation...'

if [ ! -f $INSTALL_DIR/bin/bash ]; then
  # runs ansible pre_install script
  'configuring disks and installing base system...'
  ansible-playbook -i $ANSIBLE_HOSTS $SCRIPTS_DIR/ansible/pre_setup.yml
fi

if [  $? == 0 ]; then
  cp -R $SCRIPTS_DIR $INSTALL_DIR$CHROOT_SCRIPTS_DIR
  # runs ansible install script while chrooted
  echo 'configuring boot manager, locale, network...'
  arch-chroot $INSTALL_DIR ansible-playbook -i $CHROOT_SCRIPTS_DIR/$ANSIBLE_HOSTS $CHROOT_SCRIPTS_DIR/ansible/setup.yml

  if [  $? == 0 ]; then
    'installation finished successfully, rebooting...'
    umount --recursive $INSTALL_DIR
    reboot
  fi
fi
