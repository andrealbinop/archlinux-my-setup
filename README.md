My Setup for [ArchLinux](https://www.archlinux.org/)
==========

Scripts, guides and everything needed to properly configure a linux operating system designed for software development. This version is based on [ArchLinux](https://www.archlinux.org/), and is not designed for unattended installations. This project is licensed under [MIT](LICENSE).

**Important:** It's a good practice to test the installation procedure in a virtualized environment before going to the real thing.

#### Pre-requisites
- Bootable [ArchLinux image](https://www.archlinux.org/download/). Click [here](https://wiki.archlinux.org/index.php/USB_flash_installation_media) for instructions on how to create a bootable USB.
- Internet access is required. Check here [here](https://wiki.archlinux.org/index.php/beginners%27_guide#Establish_an_internet_connection) for more information.

#### 1. Install the base system

- Boot the system with the [live media](https://www.archlinux.org/download/).
- Install [git](https://wiki.archlinux.org/index.php/Git) client and clone this project:
``` shell
pacman -Sy git
git clone https://github.com/andreptb/archlinux-my-setup.git
```
- Review the **storage** and **locale** sections of [config.yml](config.yml). When you're done run:
``` shell
./archlinux-my-setup/setup.sh
```
