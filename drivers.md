# Installing Drivers

## Prerequisites

Before installing the drivers, make sure to add the non-free and non-free-firmware components to the APT repository:

```shell
apt-add-repository --component contrib non-free non-free-firmware
apt update
```

Also, ensure that you have the kernel headers installed:

```shell
apt install linux-headers-amd64
```

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

To install firmware for Intel Wireless WiFi Link, Wireless-N, Advanced-N, and Ultimate-N devices, use:

```shell
apt install firmware-iwlwifi
```

## Resources

For more information, you can refer to the following resources:

- [Debian Graphics Card](https://wiki.debian.org/GraphicsCard)
- [Debian WiFi](https://wiki.debian.org/WiFi)
- [Debian iwlwifi](https://wiki.debian.org/iwlwifi)
