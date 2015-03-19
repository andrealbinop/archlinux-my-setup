My Setup for [ArchLinux](https://www.archlinux.org/)
==========

Scripts, guides and everything needed to properly configure a linux operating system designed for software development. This version is based on [ArchLinux](https://www.archlinux.org/), and is not designed for unattended installations. This project is licensed under [MIT](LICENSE).

**Important:** It's a good practice to test the installation procedure in a virtualized environment before going to the real thing.

#### Pre-requisites
- Bootable [ArchLinux image](https://www.archlinux.org/download/). Click [here](https://wiki.archlinux.org/index.php/USB_flash_installation_media) for instructions on how to create a bootable USB.
- Internet access is required. Check  [here](https://wiki.archlinux.org/index.php/beginners%27_guide#Establish_an_internet_connection) for more information.

#### 1. Install the base system

- Boot the system with the [live media](https://www.archlinux.org/download/).
- Install [git](https://wiki.archlinux.org/index.php/Git) and [ansible](https://www.archlinux.org/packages/community/any/ansible/):
``` shell
pacman -Sy --noconfirm ansible git
```
- Clone archlinux-my-setup project:
``` shell
git clone https://github.com/andreptb/archlinux-my-setup.git
```
- Review the [config.yml](config.yml) file. When you're done run:
``` shell
./archlinux-my-setup/setup.sh
```
- After the base installation the system will reboot. Use the configured storage to boot. Log with any configured user and run the following to complete the installation:
``` shell
/archlinux-my-setup/post_setup.sh
```
