# Debian 12 Setup Script

This script automates the setup process for a Debian 12 system, installing various software packages, configuring the GNOME desktop environment, and setting up development tools.

## Prerequisites

- A fresh installation of Debian 12 without any desktop environment.

## Usage

1. Login to the terminal as root & install required packages:
   ```shell
   apt install -y wget zip sudo
   ```
2. Optionally install drivers:
   **Prerequisites**
   Add non-free and non-free-firmware components to APT repository:
   ```shell
   apt-add-repository --component contrib non-free non-free-firmware
   apt update
   ```
   Install kernel headers:
   ```shell
   apt install linux-headers-amd64
   ```
   **Installation**
   nVidia:
   ```shell
   apt install nvidia-driver firmware-misc-nonfree
   ```
   AMD:
   ```shell
   apt install firmware-amd-graphics
   ```
   Intel:
   ```shell
   apt install xserver-xorg-video-intel
   ```
   **WiFi**
   Intel Wireless WiFi Link, Wireless-N, Advanced-N, Ultimate-N devices:
   ```
   apt install firmware-iwlwifi
   ```
   **Resources**
   [Debian Graphics Card](https://wiki.debian.org/GraphicsCard)
   [Debian WiFi](https://wiki.debian.org/WiFi)
   [Debian iwlwifi](https://wiki.debian.org/iwlwifi)
3. Add your normal user to the sudo group & reboot:
   ```shell
   usermod -aG sudo <user>
   reboot
   ```
   Note: change `<user>` to your actual username.
4. Login to the terminal as your normal user & download the setup script:
   ```shell
   wget https://github.com/sullewarehouse/debian12setup/archive/refs/heads/main.zip
   ```
5. Unzip and open directory:
   ```shell
   unzip main.zip
   cd debian12setup-main
   ```
6. Make the script executable:
   ```shell
   chmod +x install.sh
   ```
7. Run the script:
   ```shell
   bash install.sh
   ```
   Note: the script must be run as your normal user, the script will ask for root privileges to perform system updates and package installations if needed.

8. Follow the prompts and enter any required information during the script execution.

9. Sit back and relax! The script will automatically update the system, install software packages, and configure the GNOME desktop environment. Once the script finishes, your Debian 12 system will be ready for use.

LICENSE TERMS
=============
```
  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.
  
  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:
  
  (1) If any part of the source code for this software is distributed, then this
      README file must be included, with this copyright and no-warranty notice
      unaltered; and any additions, deletions, or changes to the original files
      must be clearly indicated in accompanying documentation.
  (2) Permission for use of this software is granted only if the user accepts
      full responsibility for any undesirable consequences; the authors accept
      NO LIABILITY for damages of any kind.
```

## Contributing

Contributions are welcome! If you have any improvements or bug fixes, feel free to open an issue or submit a pull request.

## Disclaimer

Please use this script at your own risk. It is recommended to review the script and ensure it aligns with your system requirements before running it. We are not responsible for any damages or data loss caused by the use of this script.

## Contact

For any questions or feedback, please feel free to contact the script maintainer:

- Maintainer: [Brian Sullender](https://github.com/b-sullender)

