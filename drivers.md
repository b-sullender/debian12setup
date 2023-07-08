# Installing Drivers

## Prerequisites

Before installing the drivers, make sure to add the non-free and non-free-firmware components to the APT repository:

```shell
apt install software-properties-common
apt-add-repository --component contrib non-free non-free-firmware
apt update
```

Also, ensure that you have the kernel headers installed:

```shell
apt install linux-headers-amd64
```

If your installing a graphics driver, disable the nouveau kernel driver:

```shell
sudo bash -c 'echo -e "blacklist nouveau\noptions nouveau modeset=0" >> /etc/modprobe.d/blacklist-nouveau.conf'
reboot
```

**Note: Some drivers, such as the nVidia graphics driver, may have issues with the command-line terminal framebuffer, causing lines to not appear on the screen properly. To address this, you can set the terminal VGA mode in the GRUB boot loader.**

To set the terminal VGA mode, follow these steps:

1. Edit the **`/etc/default/grub`** file using a text editor such as nano:
   ```shell
   sudo nano /etc/default/grub
   ```
2. Locate the line starting with **`GRUB_CMDLINE_LINUX_DEFAULT`** and append the following parameters to the existing line:
   ```shell
   GRUB_CMDLINE_LINUX_DEFAULT="quiet vga=791"
   ```
3. Save the changes by pressing **CTRL**+**O**, and exit the text editor by pressing **CTRL**+**X**.
4. Update the GRUB configuration:
   ```shell
   sudo update-grub
   ```
5. Reboot your system for the changes to take effect.

## Installation

### nVidia

To install the nVidia drivers, run the following command:

```shell
apt install nvidia-driver firmware-misc-nonfree
```

### AMD

For AMD graphics cards, use the following command to install the drivers:

```shell
apt install firmware-amd-graphics
```

### Intel

If you have an Intel graphics card, install the Intel driver with the following command:

```shell
apt install xserver-xorg-video-intel
```

## WiFi

### Tools

Install wireless tools:

```shell
apt install wireless-tools
```

### Intel

To install firmware for Intel Wireless WiFi Link, Wireless-N, Advanced-N, and Ultimate-N devices, use:

```shell
apt install firmware-iwlwifi
```

## Resources

For more information, you can refer to the following resources:

- [Debian Graphics Card](https://wiki.debian.org/GraphicsCard)
- [Debian WiFi](https://wiki.debian.org/WiFi)
- [Debian iwlwifi](https://wiki.debian.org/iwlwifi)
