#!/bin/bash

# Check if we are running as root
# Installation and packaging should always run as root!
if [ "$$(id -u)" -ne 0 ]; then echo "Please run as root 'sudo bash bookworm.sh'"; exit 1; fi

# Set default variables
timeout=10
error_log="debian12setup.log"

# System updates
apt -y update
apt -y full-upgrade

# ------------------------------------------------- #
# ----- INSTALL Debian APT AVAILABLE SOFTWARE ----- #
# ------------------------------------------------- #

# Install and start dbus
echo "Installing dbus"
apt install -y dbus
echo "Starting dbus"
systemctl start dbus

# Install software-properties-common (for apt-add-repository)
echo "Installing software-properties-common"
apt install -y software-properties-common

# Add contrib non-free (rar, etc)
echo "Adding repository components contrib non-free"
apt-add-repository --component contrib non-free

# i386 architecture for cross-compilation
echo "Adding architecture i386 to dpkg"
dpkg --add-architecture i386

# Add bullseye repository for libvpx6 and libssl1.1 (VirtualBox dependencies), python2
echo "Adding bullseye to APT sources for packages & dependencies"
echo "deb http://deb.debian.org/debian/ bullseye main" | tee /etc/apt/sources.list.d/bullseye.list

# Update APT for new architecture, repository and components
apt update

# General CLI tools
echo "Installing general CLI tools"
apt install -y wget gpg curl apt-transport-https speedtest-cli rar unrar jq htop net-tools bc lzop

# Essential coding and packaging tools
echo "Installing essential coding and packaging tools"
apt install -y gcc g++ gcc-multilib g++-multilib gcc-mingw-w64-base nasm fasm build-essential devscripts make ninja-build cmake cmake-gui git debhelper dh-make lintian default-jdk gradle libc6-i386 flex bison pahole

# Development files, examples, documentation, and misc packages
echo "Installing development files, examples, documentation and misc packages"
apt install -y dbus-x11 libx11-dev libwayland-dev libncurses-dev libssl-dev libcurl4-openssl-dev default-libmysqlclient-dev libopendkim-dev libboost-dev libwebsockets-dev libwebsocketpp-dev libopencv-dev libreadline-dev libgtk-3-dev libgtksourceview-3.0-1 libsdl2-dev libsdl2-doc qtcreator qtbase5-dev libqt5x11extras5-dev qtbase5-private-dev qtbase5-examples qt5-doc qt5-doc-html qtbase5-doc-html libepoxy-dev libpixman-1-dev libsamplerate0-dev libpcap-dev libslirp-dev libelf-dev

# Cross-compilation and embedded system packages
echo "Installing cross-compilation and embedded system packages"
apt install -y device-tree-compiler zlib1g:i386

# Scripting tools
echo "Installing scripting tools"
apt install -y php php-cli php-cgi php-json php-mysql php-curl php-zip php-xml php8.2-common python2 python3 python3-yaml python3-numpy python3-scipy python3-matplotlib python3-pandas python3-requests python3-bs4 python3-django python-django-doc python3-flask python3-sqlalchemy python3-pytest python3-virtualenv python3-bottleneck python-bottleneck-doc python3-selenium

# Code Editors, IDE's and GUI designers
echo "Installing Code Editors, IDE's and GUI designers"
apt install -y nano gedit wxhexeditor scite kate codeblocks glade

# --------------------------------------- #
# ----- Desktop Environment (GNOME) ----- #
# --------------------------------------- #

# Display Manager & Desktop Environment
echo "Installing Desktop Environment (GNOME)"
apt install -y gnome gnome-tweaks
apt install -y gnome-shell-extension-prefs chrome-gnome-shell

# Download GNOME extensions
echo "Installing GNOME extensions"
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

echo "Installing general software and tools"

# Printing system (Legacy printers require a driver installation)
apt install -y cups

# Graphical Uncomplicated Firewall
apt install -y gufw

# Firefox (web browser)
apt install -y firefox-esr

# Evolution & Thunderbird (email clients)
apt install -y evolution thunderbird

# LibreOffice suite
apt install -y libreoffice

# Image editing & painting software
apt install -y krita inkscape

# Sample any color from anywhere on the desktop, create palettes or import from images
apt install -y gpick

# VLC Media Player
apt install -y vlc

# SMPlayer (Media Player)
apt install -y smplayer

# Thumbnailer used by file managers to create thumbnails for your video files
apt install -y ffmpegthumbnailer

# Media Info
apt install -y mediainfo mediainfo-gui

# MKV Tool Nix
apt install -y mkvtoolnix mkvtoolnix-gui

# Quick Emulator & Virtual Machine Manager
apt install -y qemu-system virt-manager

# Screen Recorder
apt install -y simplescreenrecorder

# Music Editor & Video Editor
apt install -y lmms kdenlive

# Open Broadcaster Software Studio (OBS Studio)
apt install -y obs-studio

# Joystick testing and calibration for gaming
apt install -y joystick jstest-gtk

# Nintendo Entertainment System (NES) emulator
apt install -y fceux

# Nintendo GameCube emulator
apt install -y dolphin-emu

# ------------------------------------------- #
# ----- INSTALL Debian NON-APT SOFTWARE ----- #
# ------------------------------------------- #

# Get current users to Customize settings for
USERS=$(cut -d: -f1,6 /etc/passwd | awk -F: '$2 ~ /^\/home/ { print $1 }')
echo 'CURRENT USERS:'
for USER in $USERS; do
    echo $USER
done

# Copy all GNOME Nautilus (Files) document templates
echo 'Copying document templates'
for USER in $USERS; do
    # Template directory for user
    TEMPLATEDIR="/home/$USER/Templates/"
    mkdir -p $TEMPLATEDIR
    # Copy templates
    cp -r templates/* $TEMPLATEDIR
done

# ------------------------- #
# ----- Atomic Wallet ----- #
# ------------------------- #

echo "Downloading Atomic Wallet"
if wget -q --timeout=$timeout https://get.atomicwallet.io/download/atomicwallet-2.70.12.deb; then
    echo "Installing Atomic Wallet"
    apt install ./atomicwallet-2.70.12.deb
    cp /usr/share/icons/hicolor/0x0/apps/atomic.png /usr/share/icons/hicolor/256x256/apps/atomic.png
    gtk-update-icon-cache /usr/share/icons/hicolor
    rm atomicwallet-2.70.12.deb
else
    echo "Failed to download Atomic Wallet." | tee -a $error_log
fi

# ------------------------- #
# ----- Google Chrome ----- #
# ------------------------- #

echo "Downloading Google Chrome"
if wget -q --timeout=$timeout https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb; then
    echo "Installing Google Chrome"
    apt install -y ./google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
else
    echo "Failed to download Google Chrome." | tee -a $error_log
fi

# ------------------------------ #
# ----- Visual Studio Code ----- #
# ------------------------------ #

echo "Downloading Visual Studio Code GPG key"
if wget -q --timeout=$timeout -O microsoft.asc https://packages.microsoft.com/keys/microsoft.asc; then
    gpg --dearmor -o microsoft.gpg microsoft.asc
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    rm microsoft.asc
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    apt update
    echo "Installing Visual Studio Code"
    if apt install -y code; then
        echo "Visual Studio Code installed successfully."
        # Install extensions
        code --install-extension ms-vscode.cpptools
        code --install-extension ms-vscode.cpptools-themes
        code --install-extension ms-vscode.cpptools-extension-pack
        code --install-extension ms-vscode.cmake-tools
        code --install-extension ms-dotnettools.csharp
        code --install-extension GitHub.copilot
    else
        echo "Failed to install Visual Studio Code." | tee -a $error_log
    fi
else
    echo "Failed to download the GPG key for Visual Studio Code." | tee -a $error_log
fi

# -------------------------- #
# ----- GitHub Desktop ----- #
# -------------------------- #

echo "Downloading GitHub Desktop GPG key"
if wget -q --timeout=$timeout -O gpg.key https://apt.packages.shiftkey.dev/gpg.key; then
    gpg --dearmor -o /usr/share/keyrings/shiftkey-packages.gpg gpg.key
    rm gpg.key
    sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
    apt update
    echo "Installing GitHub Desktop"
    if apt install -y github-desktop; then
        echo "Github Desktop installed successfully."
    else
        echo "Failed to install Github Desktop." | tee -a $error_log
    fi
else
    echo "Failed to download the GPG key for shiftkey - Github Desktop."
fi

# ------------------- #
# ----- MakeMKV ----- #
# ------------------- #

echo "Installing MakeMKV"
apt install ./packages/makemkv_1.17.6_amd64.deb

# ------------------------------ #
# ------- Microsoft .NET ------- #
# ------------------------------ #

echo "Downloading Microsoft .NET"
if wget -q --timeout=$timeout -O packages-microsoft-prod.deb https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb; then
    echo "Installing Microsoft .NET"
    if apt install ./packages-microsoft-prod.deb; then
        rm packages-microsoft-prod.deb
        apt update
        # Install .NET SDKs and Runtimes
        if apt install -y dotnet-sdk-7.0 aspnetcore-runtime-7.0; then
            echo ".NET SDK 7.0 and ASP.NET Core Runtime 7.0 installed successfully."
        else
            echo "Failed to install .NET SDK 7.0 and ASP.NET Core Runtime 7.0." | tee -a $error_log
        fi
        if apt install -y dotnet-sdk-8.0 aspnetcore-runtime-8.0; then
            echo ".NET SDK 8.0 and ASP.NET Core Runtime 8.0 installed successfully."
        else
            echo "Failed to install .NET SDK 8.0 and ASP.NET Core Runtime 8.0." | tee -a $error_log
        fi
    else
        echo "Failed to install the Microsoft package." | tee -a $error_log
    fi
else
    echo "Failed to download the Microsoft package." | tee -a $error_log
fi

# ---------------------- #
# ----- VirtualBox ----- #
# ---------------------- #

# Install dependencies
echo "Installing VirtualBox dependencies (libvpx6, libssl1.1)"
apt install -y libvpx6 libssl1.1

# Install VirtualBox itself
echo "Downloading VirtualBox GPG key"
if wget -q --timeout=$timeout -O oracle_vbox_2016.asc https://www.virtualbox.org/download/oracle_vbox_2016.asc; then
    gpg --dearmor --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg oracle_vbox_2016.asc
    rm oracle_vbox_2016.asc
    sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bookworm contrib" > /etc/apt/sources.list.d/virtualbox.list'
    apt update
    # Install VirtualBox
    echo "Installing VirtualBox"
    if apt install -y virtualbox-7.0; then
        echo "VirtualBox installed successfully."
        # Download and install the VirtualBox Extension Pack
        if wget -q --timeout=$timeout https://download.virtualbox.org/virtualbox/7.0.0/Oracle_VM_VirtualBox_Extension_Pack-7.0.0.vbox-extpack; then
            VBoxManage extpack install --replace Oracle_VM_VirtualBox_Extension_Pack-7.0.0.vbox-extpack
            rm Oracle_VM_VirtualBox_Extension_Pack-7.0.0.vbox-extpack
        else
            echo "Failed to download the VirtualBox Extension Pack." | tee -a $error_log
        fi
        # Add all current users to the 'vboxusers' group
        for USER in $USERS; do
            if usermod -aG vboxusers "$USER"; then
                echo "User $USER added to vboxusers group."
            else
                echo "Failed to add user $USER to vboxusers group." | tee -a $error_log
            fi
        done
    else
        echo "Failed to install VirtualBox." | tee -a $error_log
    fi
else
    echo "Failed to download the GPG key for VirtualBox." | tee -a $error_log
fi

# ------------------------------- #
# ----- Setup GNOME Desktop ----- #
# ------------------------------- #

echo "Setting up GNOME tweaks and extensions"

# Check if DBUS_SESSION_BUS_ADDRESS is set
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    echo "D-Bus session not found. Starting a new session..."
    eval $(dbus-launch)
    export DBUS_SESSION_BUS_ADDRESS
    export DBUS_SESSION_BUS_PID
else
    echo "D-Bus session already running."
fi

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

# ----------------------------------------------- #
# ----- Copy wallpapers and create XML file ----- #
# ----------------------------------------------- #

echo "Copying icons & wallpapers"

# Wallpaper directory
WALLPAPERDIR="/usr/share/backgrounds/wallpapers"
mkdir -p $WALLPAPERDIR

# Copy wallpapers
cp -r wallpapers/* $WALLPAPERDIR

# Output XML file for wallpapers
XMLFILE="/usr/share/gnome-background-properties/d12setup-wallpapers.xml"
mkdir -p $(dirname $XMLFILE)

# Start XML content
XMLCONTENT='<?xml version="1.0"?>\n<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">\n<wallpapers>\n'

# Iterate over each file in the wallpaper directory
for FILE in "$WALLPAPERDIR"/*; do
  BASENAME=$(basename "$FILE")
  XMLCONTENT+="  <wallpaper>\n"
  XMLCONTENT+="    <name>$BASENAME</name>\n"
  XMLCONTENT+="    <filename>$WALLPAPERDIR/$BASENAME</filename>\n"
  XMLCONTENT+="    <options>zoom</options>\n"
  XMLCONTENT+="    <shade_type>solid</shade_type>\n"
  XMLCONTENT+="  </wallpaper>\n"
done

# Close XML content
XMLCONTENT+="</wallpapers>"

# Write XML content to file
echo -e $XMLCONTENT | tee $XMLFILE > /dev/null
echo "Wallpaper XML file created at $XMLFILE"

# -------------------------------------------------- #
# ----- Delete unwanted icons & copy new icons ----- #
# -------------------------------------------------- #

# Delete Code::Blocks original icon
rm /usr/share/pixmaps/codeblocks.png

# Copy Code::Blocks new icon
cp icons/codeblocks.svg /usr/share/pixmaps/codeblocks.svg

# --------------------------------------- #
# ----- Setup for each user desktop ----- #
# --------------------------------------- #

echo "Setting user GNOME extensions & settings"
for USER in $USERS; do
  
  # Set wallpaper
  #gsettings set org.gnome.desktop.background picture-uri "file:///$WALLPAPERDIR//niagara river.jpg"
  #gsettings set org.gnome.desktop.background picture-uri-dark "file:///$WALLPAPERDIR//niagara river.jpg"
  
  # Or select a random wallpaper
  WALLPAPER=$(ls $WALLPAPERDIR | shuf -n 1)
  gsettings set org.gnome.desktop.background picture-uri "file:///$WALLPAPERDIR//$WALLPAPER"
  gsettings set org.gnome.desktop.background picture-uri-dark "file:///$WALLPAPERDIR//$WALLPAPER"
  
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
