# Welcome to the FenceOS Beta (Arch) installation script!
# This installation script will require an internet connection
# This script will install an Arch Linux based version of FenceOS

# You will now partition your disk and select the partitions that FenceOS uses
# By default, the installation script uses /dev/sda as the drive FenceOS is installed on

fdisk /dev/sda
n
n
w
q

# The new partitions will now be formatted

mkfs.ext4 /dev/sda1
mkswap /dev/sda2

# The partitions will now be mounted

mount /dev/sda1 /mnt
swapon /dev/sda2

# You will now change the mirrorlist file to have a faster installation

sudo nano /etc/pacman.d/mirrorlist

# Two linux kernels (linux, linux-lts) will now be installed

pacstrap /mnt base linux linux-lts linux-firmware

# An fstab will now be created
genfstab -U /mnt >> /mnt/etc/fstab

# We will now chroot into the installed system

arch-chroot /mnt

# The timezone will be set

ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc

# You will now set the locale

locale-gen

# Please edit this file to enable your locale

# By default, the locale is set to en_gb and the keymap is UK

sudo nano /etc/locale.gen
LANG=en_GB.UTF-8

sudo nano /etc/vconsole.conf
KEYMAP=gb_english

# The network will be configured

sudo nano /etc/hostname
fenceos

sudo nano /etc/hosts
127.0.0.1	fenceos
::1		fenceos
127.0.1.1	fenceos.fenceos	fenceos

# The root password will now be set

passwd

# A new user (fenceos) will now be created

adduser -m -G wheel,audio,video,input,sudoers

# The password for the now user will now be set

passwd fenceos

# Extra packages will now be installed
# The packages consist of: neovim, bluez, neofetch, spotify, discord, steam, vlc, lutris, arandr, rofi, pulseaudio, pavucontrol, pamac, yay, obs, brave

sudo pacman -S neovim bluez neofetch spotify discord steam vlc lutris arandr rofi pulseaudio pavucontrol, pamac, yay -y
yay -S obs brave

exit

# FenceOS (base) is now installed
# Please run ./pacman-gui to install the graphical user interface
# Once you are finished, please run ./complete to complete the installation and reboot

printf (“ FenceOS (base) is now installed!
 Please run ./pacman-gui to install the graphical user interface.
 Once you are finished, please run ./complete to complete the installation and reboot.”)