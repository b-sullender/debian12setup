#!/bin/bash

# System updates
sudo apt -y update
sudo apt -y upgrade
sudo apt -y dist-upgrade

# ------------------------------------------------- #
# ----- INSTALL Debian APT AVAILABLE SOFTWARE ----- #
# ------------------------------------------------- #

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

# General CLI tools
sudo apt install -y wget gpg curl apt-transport-https speedtest-cli

# Essential coding tools
sudo apt install -y gcc g++ gcc-multilib g++-multilib gcc-mingw-w64-base
sudo apt install -y build-essential devscripts debhelper dh-make
sudo apt install -y make cmake cmake-gui git

# dev files
sudo apt install -y libx11-dev libwayland-dev
sudo apt install -y libncurses-dev libssl-dev libcurl4-openssl-dev default-libmysqlclient-dev libopendkim-dev libboost-dev libwebsockets-dev libwebsocketpp-dev libopencv-dev libreadline-dev
sudo apt install -y libgtk-3-dev qtcreator qtbase5-dev qtbase5-examples qt5-doc qt5-doc-html qtbase5-doc-html

# * See NOTES at the bottom for details on linking and compiling * #

# Scripting tools
sudo apt install -y php php-cli php-cgi php-json php-mysql php-curl php-zip php-xml php-fileinfo

# Code Editors and IDE's
sudo apt install -y nano gedit scite kate codeblocks

# -------------------------------------- #
# ----- GENERAL SOFTWARE AND TOOLS ----- #
# -------------------------------------- #

# Printing system (Legacy printers require a driver installation)
sudo apt install -y cups

# Joystick testing and calibration for gaming
sudo apt install -y joystick jstest-gtk

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

# ------------------------------------------- #
# ----- INSTALL Debian NON-APT SOFTWARE ----- #
# ------------------------------------------- #

# ------------------------- #
# ----- Atomic Wallet ----- #
# ------------------------- #

# Download the application
wget https://get.atomicwallet.io/download/atomicwallet-2.70.12.deb

# Install the application
sudo apt install ./atomicwallet-2.70.12.deb

# Copy the icon to a suitable location
sudo cp /usr/share/icons/hicolor/0x0/apps/atomic.png /usr/share/icons/hicolor/256x256/apps/atomic.png

# Update icon cache for Atomic Wallet
sudo gtk-update-icon-cache /usr/share/icons/hicolor

# ------------------------- #
# ----- Google Chrome ----- #
# ------------------------- #

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# ------------------------------ #
# ----- Visual Studio Code ----- #
# ------------------------------ #

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt update
sudo apt install code

# Install extensions
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.cpptools-themes
code --install-extension ms-vscode.cpptools-extension-pack
code --install-extension ms-vscode.cmake-tools
code --install-extension ms-dotnettools.csharp
code --install-extension GitHub.copilot

# -------------------------- #
# ----- GitHub Desktop ----- #
# -------------------------- #

wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'

sudo apt update
sudo apt install github-desktop

# ------------------- #
# ----- MakeMKV ----- #
# ------------------- #

# Install required packages
sudo apt install -y build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev qtbase5-dev zlib1g-dev

# Download Files
wget https://www.makemkv.com/download/makemkv-bin-1.17.4.tar.gz
wget https://www.makemkv.com/download/makemkv-oss-1.17.4.tar.gz

# Unzip Files and Remove tarballs
tar -xvvf makemkv-bin-1.17.4.tar.gz
tar -xvvf makemkv-oss-1.17.4.tar.gz
sudo rm makemkv-bin-1.17.4.tar.gz
sudo rm makemkv-oss-1.17.4.tar.gz

# Build OSS and BIN
cd makemkv-oss-1.17.4
chmod +x configure
./configure
make
sudo make install
cd ../makemkv-bin-1.17.4
make
sudo make install
cd ..

# Update icon cache for MakeMKV
sudo gtk-update-icon-cache /usr/share/icons/hicolor

# Remove Directories
sudo rm -r makemkv-oss-1.17.4
sudo rm -r makemkv-bin-1.17.4

# ------------------------ #
# ----- Install .NET ----- #
# ------------------------ #

wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt update
sudo apt install -y dotnet-sdk-7.0 aspnetcore-runtime-7.0

# ---------------------- #
# ----- VirtualBox ----- #
# ---------------------- #

# Download dependencies
wget http://http.us.debian.org/debian/pool/main/o/openssl/libssl1.1_1.1.1n-0+deb11u5_amd64.deb
wget http://http.us.debian.org/debian/pool/main/libv/libvpx/libvpx6_1.9.0-1_amd64.deb

# Install dependencies
sudo dpkg -i libssl1.1_1.1.1n-0+deb11u5_amd64.deb
sudo dpkg -i libvpx6_1.9.0-1_amd64.deb

# Delete files
rm libssl1.1_1.1.1n-0+deb11u5_amd64.deb
rm libvpx6_1.9.0-1_amd64.deb

wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bullseye contrib" > /etc/apt/sources.list.d/virtualbox.list'

sudo apt update
sudo apt install -y virtualbox-7.0

wget https://download.virtualbox.org/virtualbox/7.0.0/Oracle_VM_VirtualBox_Extension_Pack-7.0.0.vbox-extpack
VBoxManage extpack install --replace Oracle_VM_VirtualBox_Extension_Pack-7.0.0.vbox-extpack
rm Oracle_VM_VirtualBox_Extension_Pack-7.0.0.vbox-extpack

# ------------------------------- #
# ----- Setup GNOME Desktop ----- #
# ------------------------------- #

# Set GNOME tweaks settings
gsettings set org.gnome.desktop.wm.preferences button-layout 'icon:minimize,maximize,close'
gsettings set org.gnome.mutter center-new-windows true

# Use the following to find a GNOME setting
#   gsettings list-recursively > /tmp/gsettings.before
#   gsettings list-recursively > /tmp/gsettings.after
#   diff /tmp/gsettings.before /tmp/gsettings.after | grep '[>|<]'

# Enable extensions
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gnome-extensions enable apps-menu@gnome-shell-extensions.gcampax.github.com

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
  gsettings set org.gnome.desktop.background picture-uri "file:///$WALLPAPERDIR//niagara river.jpg"
  
  # ----------------------------------------------- #
  # ----- Set dash-to-dock extension settings ----- #
  # ----------------------------------------------- #
  
  SCHEMADIR="/home/$USER/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/"
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock dock-fixed true
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock extend-height true
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 36
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock animate-show-apps false
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock show-trash true
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock show-mounts false
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'SEGMENTED'
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock unity-backlit-items false
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color true
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock custom-theme-customize-running-dots false
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
  gsettings --schemadir $SCHEMADIR set org.gnome.shell.extensions.dash-to-dock background-opacity 0.75
  
  # Use the following to list keys and current values of dash-to-dock extension **** change <user> to the actual users directory name ****
  #   gsettings --schemadir /home/<user>/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ list-recursively org.gnome.shell.extensions.dash-to-dock
  
done

# ----------------------------- #
# ----- Set favorite-apps ----- #
# ----------------------------- #

gsettings set org.gnome.shell favorite-apps "['firefox-esr.desktop', 'thunderbird.desktop', 'org.gnome.Terminal.desktop', 'code.desktop', 'org.qt-project.qtcreator.desktop', 'codeblocks.desktop', 'org.kde.kate.desktop', 'org.gnome.gedit.desktop', 'org.gnome.Calculator.desktop', 'github-desktop.desktop', 'cmake-gui.desktop', 'libreoffice-writer.desktop', 'org.gnome.Rhythmbox3.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Calendar.desktop', 'makemkv.desktop', 'virtualbox.desktop', 'org.gnome.Software.desktop', 'gufw.desktop']"

# Use the following the get your favorite apps list
#   gsettings get org.gnome.shell favorite-apps

# ----------------------- #
# ----- WE ARE DONE ----- #
# ----------------------- #

systemctl reboot

# ----------------- #
# ----- NOTES ----- #
# ----------------- #

# Linking Options:
# cURL:
# -lcurl

# libwebsockets:
# -lwebsockets

# MySQL Client:
# -lmysqlclient

# OpenSSL:
# -lssl -lcrypto

# OpenDKIM:
# -lopendkim

