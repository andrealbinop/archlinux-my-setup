My Setup for [ArchLinux](https://www.archlinux.org/)
==========

This project tries to automate the steps required to install [ArchLinux](https://wiki.archlinux.org), inspired by [ArchLinux beginner guide](https://wiki.archlinux.org/index.php/beginners%27_guide). This project is not designed for unattended installations, use at your own risk. This project is licensed under [MIT](LICENSE).


**Important:** It's a good practice to test the installation procedure in a virtualized environment before going to the real thing.

#### Pre-requisites
- Bootable [ArchLinux image](https://www.archlinux.org/download/). Click [here](https://wiki.archlinux.org/index.php/USB_flash_installation_media) for instructions on how to create a bootable USB.
- Internet access is required. Check  [here](https://wiki.archlinux.org/index.php/beginners%27_guide#Establish_an_internet_connection) for more information.

#### Usage

- Boot the system with the [live media](https://www.archlinux.org/download/).
- Install [git](https://wiki.archlinux.org/index.php/Git) and [ansible](https://www.archlinux.org/packages/community/any/ansible/):
``` shell
pacman -Sy --noconfirm ansible git
```
- Clone archlinux-my-setup project:
``` shell
git clone https://github.com/andreptb/archlinux-my-setup.git
```
- Review the [config.yml](config.yml) file. Every aspect of configuration of the installation is here. When you're done run:
``` shell
./archlinux-my-setup/setup.sh
```
- After the base installation the system will reboot. Use the configured storage to boot. Log with any configured user and run the following to complete the installation:
``` shell
sudo /archlinux-my-setup/post_setup.sh
```

#### Vagrant

A reference Arch Linux installation built with **archlinux-my-setup** can be tested with [Vagrant](https://www.vagrantup.com/docs/getting-started/). To start just run:
``` shell
vagrant init andreptb/archlinux
vagrant up
```
