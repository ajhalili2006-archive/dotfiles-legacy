# Bloody Docs for installing Arch Linux

## Afer booting into the hell

If you're inside an Virtualbox eenvironment, make sure SSH is enabled and setup port forwarding stuff. Don't forget changing the root password for live
environment with something like `linussextips69` (DON'T USE THAT ON OTHER APPS!)

* Create partitons then format with ext4. If desired to seperate /home from the rest of the Arch install, create seperate partitions and mount it as `/mnt/home`.
* Afer mounting the target partition and other stuff, run `pacstrap /mnt base linux linux-firmware nano git zsh grub` to bootstrap the Arch Linux base.
* Generate fstabs with `genfstab -U /mnt >> /mnt/etc/fstab`

Now, chroot into target partition with `arch-chroot /mnt`.

## Inside the chroot environment

### VirtualBox-specific setup

Install `virtualbox-guest-utils`

### GRUB Bootloader

If you ever do multibooting, please see <https://wiki.archlinux.org/title/GRUB#Detecting_other_operating_systems> for more detailed docs.

* BIOS/CSR mode:

```sh
# Change sda into device name for your target hard drive/SSD
grub-install --target=i386-pc /dev/sda; grub-mkconfig -o /boot/grub/grub.cfg
```

* UEFI/EFI, Secure Boot disabled:

```sh
# Change sda into device name for your target hard drive/SSD
grub-install --target=i386-pc /dev/sda; grub-mkconfig -o /boot/grub/grub.cfg
```

* With Secure Boot:

## Final Steps

* Exit the chroot and reboot. Don't forget to remove the installation media before the reboot.
