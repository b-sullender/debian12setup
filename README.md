# Debian 12 Setup Script

This script automates the setup process for a Debian 12 system, installing various software packages, configuring the GNOME desktop environment, and setting up development tools.

## Prerequisites

- A fresh installation of Debian 12 without any desktop environment.

## Usage

1. Login to the terminal as root & install required packages:
   ```shell
   apt install -y wget zip sudo git
   ```
   Optionally install drivers: [Installing Drivers](drivers.md)
2. Add your normal user to the sudo group & reboot:
   ```shell
   usermod -aG sudo <user>
   reboot
   ```
   Note: change `<user>` to your actual username.
3. Login to the terminal as your normal user & clone the repository using git:
   ```shell
   git clone https://github.com/b-sullender/debian12setup.git
   ```
4. Open directory:
   ```shell
   cd debian12setup
   ```
5. Make the script executable:
   ```shell
   chmod +x install.sh
   ```
6. Run the script:
   ```shell
   bash install.sh
   ```
   Note: the script must be run as your normal user, the script will ask for root privileges to perform system updates and package installations if needed.

7. Follow the prompts and enter any required information during the script execution.

8. Sit back and relax! The script will automatically update the system, install software packages, and configure the GNOME desktop environment. Once the script finishes, your Debian 12 system will be ready for use.

## 4K Resolution & Above

If you are using a 4K resolution or higher, you may want to scale the login screen accordingly. Follow these steps to adjust the login screen scaling:

1. Create an override file by running the following command:
   ```shell
   echo -e "[org.gnome.desktop.interface]\nscaling-factor=2" | sudo tee /usr/share/glib-2.0/schemas/93_hidpi.gschema.override > /dev/null
   ```
   Note: Change the value of `scaling-factor` (e.g., `2`) to fit your needs.
2. Reinitialize the schemas by executing the following command:
   ```shell
   sudo glib-compile-schemas /usr/share/glib-2.0/schemas
   ```

This will successfully scale the login screen for 4K resolution and above.

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

## Screenshot

![Screenshot](screenshot.png)

