#!/bin/bash

timeout=10
error_log="debian12setup.log"

# System updates
sudo apt -y update
sudo apt -y upgrade
sudo apt -y dist-upgrade

# ------------------------------------------------- #
# ----- INSTALL Debian APT AVAILABLE SOFTWARE ----- #
# ------------------------------------------------- #

# Add contrib non-free (rar, etc)
sudo apt-add-repository --component contrib non-free

# i386 architecture for cross-compilation
sudo dpkg --add-architecture i386

# Add bullseye repository for python2
echo "deb http://deb.debian.org/debian/ bullseye main" | sudo tee /etc/apt/sources.list.d/bullseye.list

# Update APT for new architecture, repository and components
sudo apt update

# General CLI tools
sudo apt install -y wget gpg curl apt-transport-https speedtest-cli rar unrar

# Essential coding and packaging tools
sudo apt install -y gcc g++ gcc-multilib g++-multilib gcc-mingw-w64-base nasm fasm build-essential devscripts make ninja-build cmake cmake-gui git debhelper dh-make lintian default-jdk gradle

# Development files, examples, documentation and misc
sudo apt install -y dbus-x11 libx11-dev libwayland-dev libncurses-dev libssl-dev libcurl4-openssl-dev default-libmysqlclient-dev libopendkim-dev libboost-dev libwebsockets-dev libwebsocketpp-dev libopencv-dev libreadline-dev libgtk-3-dev libgtksourceview-3.0-1 libsdl2-dev libsdl2-doc qtcreator qtbase5-dev libqt5x11extras5-dev qtbase5-private-dev qtbase5-examples qt5-doc qt5-doc-html qtbase5-doc-html libepoxy-dev libpixman-1-dev libsamplerate0-dev libpcap-dev libslirp-dev device-tree-compiler

# Scripting tools
sudo apt install -y php php-cli php-cgi php-json php-mysql php-curl php-zip php-xml php8.2-common python2 python3 python3-yaml python3-numpy python3-scipy python3-matplotlib python3-pandas python3-requests python3-bs4 python3-django python-django-doc python3-flask python3-sqlalchemy python3-pytest python3-virtualenv python3-bottleneck python-bottleneck-doc python3-selenium

# Code Editors, IDE's and GUI designers
sudo apt install -y nano gedit wxhexeditor scite kate codeblocks glade

# --------------------------------------- #
# ----- Desktop Environment (GNOME) ----- #
# --------------------------------------- #

# Display Manager & Desktop Environment
sudo apt install -y gnome gnome-tweaks
sudo apt install -y gnome-shell-extension-prefs chrome-gnome-shell

# Download GNOME extensions
wget https://extensions.gnome.org/extension-data/dash-to-dockmicxgx.gmail.com.v84.shell-extension.zip
wget https://extensions.gnome.org/extension-data/apps-menugnome-shell-extensions.gcampax.github.com.v52.shell-extension.zip
wget https://extensions.gnome.org/extension-data/VitalsCoreCoding.com.v61.shell-extension.zip

# Install GNOME extensions
gnome-extensions install dash-to-dockmicxgx.gmail.com.v84.shell-extension.zip
gnome-extensions install apps-menugnome-shell-extensions.gcampax.github.com.v52.shell-extension.zip
gnome-extensions install VitalsCoreCoding.com.v61.shell-extension.zip

# Delete GNOME extension files
rm dash-to-dockmicxgx.gmail.com.v84.shell-extension.zip
rm apps-menugnome-shell-extensions.gcampax.github.com.v52.shell-extension.zip
rm VitalsCoreCoding.com.v61.shell-extension.zip

# -------------------------------------- #
# ----- GENERAL SOFTWARE AND TOOLS ----- #
# -------------------------------------- #

# Printing system (Legacy printers require a driver installation)
sudo apt install -y cups

# Graphical Uncomplicated Firewall
sudo apt install -y gufw

# Firefox (web browser)
sudo apt install -y firefox-esr

# Evolution & Thunderbird (email clients)
sudo apt install -y evolution thunderbird

# LibreOffice suite
sudo apt install -y libreoffice

# Image editing & painting software
sudo apt install -y krita inkscape

# VLC Media Player
sudo apt install -y vlc

# SMPlayer (Media Player)
sudo apt install -y smplayer

# Thumbnailer used by file managers to create thumbnails for your video files
sudo apt install -y ffmpegthumbnailer

# Media Info
sudo apt install -y mediainfo mediainfo-gui

# MKV Tool Nix
sudo apt install -y mkvtoolnix mkvtoolnix-gui

# Quick Emulator & Virtual Machine Manager
sudo apt install -y qemu-system virt-manager

# Screen Recorder
sudo apt install -y simplescreenrecorder

# Music Editor & Video Editor
sudo apt install -y lmms kdenlive

# Open Broadcaster Software Studio (OBS Studio)
sudo apt install -y obs-studio

# Joystick testing and calibration for gaming
sudo apt install -y joystick jstest-gtk

# Nintendo Entertainment System (NES) emulator
sudo apt install -y fceux

# Nintendo GameCube emulator
sudo apt install -y dolphin-emu

# ------------------------------------------- #
# ----- INSTALL Debian NON-APT SOFTWARE ----- #
# ------------------------------------------- #

# ------------------------- #
# ----- Atomic Wallet ----- #
# ------------------------- #

if sudo wget -q --timeout=$timeout https://get.atomicwallet.io/download/atomicwallet-2.70.12.deb; then
    sudo apt install ./atomicwallet-2.70.12.deb
    sudo cp /usr/share/icons/hicolor/0x0/apps/atomic.png /usr/share/icons/hicolor/256x256/apps/atomic.png
    sudo gtk-update-icon-cache /usr/share/icons/hicolor
    sudo rm atomicwallet-2.70.12.deb
else
    echo "Failed to download Atomic Wallet." | sudo tee -a $error_log
fi

# ------------------------- #
# ----- Google Chrome ----- #
# ------------------------- #

if sudo wget -q --timeout=$timeout https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb; then
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
    sudo rm google-chrome-stable_current_amd64.deb
else
    echo "Failed to download Google Chrome." | sudo tee -a $error_log
fi

# ------------------------------ #
# ----- Visual Studio Code ----- #
# ------------------------------ #

if sudo wget -q --timeout=$timeout -O microsoft.asc https://packages.microsoft.com/keys/microsoft.asc; then
    gpg --dearmor -o microsoft.gpg microsoft.asc
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo rm microsoft.asc
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    if sudo apt install -y code; then
        echo "Visual Studio Code installed successfully."
        # Install extensions
        code --install-extension ms-vscode.cpptools
        code --install-extension ms-vscode.cpptools-themes
        code --install-extension ms-vscode.cpptools-extension-pack
        code --install-extension ms-vscode.cmake-tools
        code --install-extension ms-dotnettools.csharp
        code --install-extension GitHub.copilot
    else
        echo "Failed to install Visual Studio Code." | sudo tee -a $error_log
    fi
else
    echo "Failed to download the GPG key for Visual Studio Code." | sudo tee -a $error_log
fi

# -------------------------- #
# ----- GitHub Desktop ----- #
# -------------------------- #

if sudo wget -q --timeout=$timeout -O gpg.key https://apt.packages.shiftkey.dev/gpg.key; then
    sudo gpg --dearmor -o /usr/share/keyrings/shiftkey-packages.gpg gpg.key
    sudo rm gpg.key
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
    sudo apt update
    if sudo apt install -y github-desktop; then
        echo "Github Desktop installed successfully."
    else
        echo "Failed to install Github Desktop." | sudo tee -a $error_log
    fi
else
    echo "Failed to download the GPG key for shiftkey - Github Desktop."
fi

# ------------------- #
# ----- MakeMKV ----- #
# ------------------- #

sudo dpkg -i packages/makemkv_1.17.6_amd64.deb

# ------------------------------ #
# ------- Microsoft .NET ------- #
# ------------------------------ #

if sudo wget -q --timeout=$timeout -O packages-microsoft-prod.deb https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb; then
    if sudo dpkg -i packages-microsoft-prod.deb; then
        sudo rm packages-microsoft-prod.deb
        sudo apt update
        # Install .NET SDKs and Runtimes
        if sudo apt install -y dotnet-sdk-7.0 aspnetcore-runtime-7.0; then
            echo ".NET SDK 7.0 and ASP.NET Core Runtime 7.0 installed successfully."
        else
            echo "Failed to install .NET SDK 7.0 and ASP.NET Core Runtime 7.0." | sudo tee -a $error_log
        fi
        if sudo apt install -y dotnet-sdk-8.0 aspnetcore-runtime-8.0; then
            echo ".NET SDK 8.0 and ASP.NET Core Runtime 8.0 installed successfully."
        else
            echo "Failed to install .NET SDK 8.0 and ASP.NET Core Runtime 8.0." | sudo tee -a $error_log
        fi
    else
        echo "Failed to install the Microsoft package." | sudo tee -a $error_log
    fi
else
    echo "Failed to download the Microsoft package." | sudo tee -a $error_log
fi

# ---------------------- #
# ----- VirtualBox ----- #
# ---------------------- #

# Install dependencies
sudo dpkg -i packages/libssl1.1_1.1.1n-0+deb10u3_amd64.deb
sudo dpkg -i packages/libvpx6_1.9.0-1+deb11u2_amd64.deb

if sudo wget -q --timeout=$timeout -O oracle_vbox_2016.asc https://www.virtualbox.org/download/oracle_vbox_2016.asc; then
    sudo gpg --dearmor --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg oracle_vbox_2016.asc
    sudo rm oracle_vbox_2016.asc
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bookworm contrib" > /etc/apt/sources.list.d/virtualbox.list'
    sudo apt update
    # Install VirtualBox
    if sudo apt install -y virtualbox-7.0; then
        echo "VirtualBox installed successfully."
        # Download and install the VirtualBox Extension Pack
        if sudo wget -q --timeout=$timeout https://download.virtualbox.org/virtualbox/7.0.0/Oracle_VM_VirtualBox_Extension_Pack-7.0.0.vbox-extpack; then
            sudo VBoxManage extpack install --replace Oracle_VM_VirtualBox_Extension_Pack-7.0.0.vbox-extpack
            sudo rm Oracle_VM_VirtualBox_Extension_Pack-7.0.0.vbox-extpack
        else
            echo "Failed to download the VirtualBox Extension Pack." | sudo tee -a $error_log
        fi
        # Get the current username
        current_user=$(whoami)
        # Add the current user to the 'vboxusers' group
        if sudo usermod -aG vboxusers "$current_user"; then
            echo "User $current_user added to vboxusers group."
        else
            echo "Failed to add user $current_user to vboxusers group." | sudo tee -a $error_log
        fi
    else
        echo "Failed to install VirtualBox." | sudo tee -a $error_log
    fi
else
    echo "Failed to download the GPG key for VirtualBox." | sudo tee -a $error_log
fi

# ------------------------------- #
# ----- Setup GNOME Desktop ----- #
# ------------------------------- #

# Set GNOME tweaks settings
dbus-launch gsettings set org.gnome.desktop.wm.preferences button-layout 'icon:minimize,maximize,close'
dbus-launch gsettings set org.gnome.mutter center-new-windows true

# Use the following to find a GNOME setting
#   gsettings list-recursively > /tmp/gsettings.before
#   gsettings list-recursively > /tmp/gsettings.after
#   diff /tmp/gsettings.before /tmp/gsettings.after | grep '[>|<]'

# Enable extensions
dbus-launch gnome-extensions enable dash-to-dock@micxgx.gmail.com
dbus-launch gnome-extensions enable apps-menu@gnome-shell-extensions.gcampax.github.com

# ----------------------------------- #
# ----- Copy icons & wallpapers ----- #
# ----------------------------------- #

# Wallpaper directory
WALLPAPERDIR="/usr/share/backgrounds/wallpapers"
sudo mkdir $WALLPAPERDIR

# Copy wallpapers
sudo cp -r wallpapers/* $WALLPAPERDIR

# Delete Code::Blocks original icon
sudo rm /usr/share/pixmaps/codeblocks.png

# Copy Code::Blocks new icon
sudo cp icons/codeblocks.svg /usr/share/pixmaps/codeblocks.svg

# --------------------------------------- #
# ----- Setup for each user desktop ----- #
# --------------------------------------- #

USERS=$(cut -d: -f1,6 /etc/passwd | awk -F: '$2 ~ /^\/home/ { print $1 }')
for USER in $USERS; do
  
  # Set wallpaper
  dbus-launch gsettings set org.gnome.desktop.background picture-uri "file:///$WALLPAPERDIR//niagara river.jpg"
  
  # ----------------------------------------------- #
  # ----- Set dash-to-dock extension settings ----- #
  # ----------------------------------------------- #
  
  SCHEMADIR="/home/$USER/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/"
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock dock-fixed true
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock extend-height true
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 36
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock animate-show-apps false
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock show-trash true
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock show-mounts false
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'SEGMENTED'
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock unity-backlit-items false
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color true
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock custom-theme-customize-running-dots false
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
  dbus-launch gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock background-opacity 0.75
  
  # Use the following to list keys and current values of dash-to-dock extension **** change <user> to the actual users directory name ****
  #   dbus-launch gsettings --schemadir /home/<user>/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ list-recursively org.gnome.shell.extensions.dash-to-dock
  
done

# ----------------------------- #
# ----- Set favorite-apps ----- #
# ----------------------------- #

dbus-launch gsettings set org.gnome.shell favorite-apps "['firefox-esr.desktop', 'thunderbird.desktop', 'org.gnome.Terminal.desktop', 'code.desktop', 'org.qt-project.qtcreator.desktop', 'codeblocks.desktop', 'org.kde.kate.desktop', 'org.gnome.gedit.desktop', 'org.gnome.Calculator.desktop', 'github-desktop.desktop', 'cmake-gui.desktop', 'libreoffice-writer.desktop', 'org.gnome.Rhythmbox3.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Calendar.desktop', 'makemkv.desktop', 'virtualbox.desktop', 'org.gnome.Software.desktop', 'gufw.desktop']"

# Use the following the get your favorite apps list
#   dbus-launch gsettings get org.gnome.shell favorite-apps

# ----------------------- #
# ----- WE ARE DONE ----- #
# ----------------------- #

sudo systemctl reboot

