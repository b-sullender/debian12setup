#!/bin/bash

# Function to print in red
print_red() {
    echo -e "\e[31m$1\e[0m"
}

# Check if we are running as root
# - Configuring GNOME settings is user specific and root causes issues
if [ "$(id -u)" -eq 0 ]; then
    print_red "Please run as non-root (NOT root) 'bash config-gnome.sh'"
    exit 1
fi

# Save both stdout and stderr to a single file through tee
exec > >(tee config-gnome.log) 2>&1

# Function to install necessary packages
check_and_install() {
    local REQUIRED_PKGS=("$@")
    local MISSING_PKGS=()

    # Check each required package
    for pkg in "${REQUIRED_PKGS[@]}"; do
        PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $pkg | grep "install ok installed")
        echo Checking for $pkg: $PKG_OK
        if [ "" = "$PKG_OK" ]; then
          MISSING_PKGS+=("$pkg")
        fi
    done

    # If there are missing packages, prompt user to install them
    if [ ${#MISSING_PKGS[@]} -gt 0 ]; then
        echo "Packages ${MISSING_PKGS[@]} are not installed."
        read -p "Do you want to install them now? (y/n): " response
        if [ "$response" = "y" ]; then
            if sudo apt install -y "${MISSING_PKGS[@]}"; then
                echo "${MISSING_PKGS[@]} installed successfully."
            else
                print_red "Failed to install ${MISSING_PKGS[@]}"
                exit 1
            fi
        else
            echo "Cannot proceed without ${MISSING_PKGS[@]}. Exiting."
            exit 1
        fi
    fi
}

echo "Checking for Desktop Environment & Extensions"
check_and_install "gnome" "gnome-tweaks" "gnome-shell-extension-prefs" "chrome-gnome-shell"

# Get user name
USER=$(whoami)

echo "Configuring GNOME preferences"
gsettings set org.gnome.desktop.wm.preferences button-layout 'icon:minimize,maximize,close'
gsettings set org.gnome.mutter center-new-windows true

# Use the following to find a GNOME setting
#   gsettings list-recursively > /tmp/gsettings.before
#   gsettings list-recursively > /tmp/gsettings.after
#   diff /tmp/gsettings.before /tmp/gsettings.after | grep '[>|<]'

echo "Downloading GNOME extensions"
wget https://extensions.gnome.org/extension-data/dash-to-dockmicxgx.gmail.com.v84.shell-extension.zip
wget https://extensions.gnome.org/extension-data/apps-menugnome-shell-extensions.gcampax.github.com.v52.shell-extension.zip
wget https://extensions.gnome.org/extension-data/VitalsCoreCoding.com.v61.shell-extension.zip
wget https://extensions.gnome.org/extension-data/tactilelundal.io.v27.shell-extension.zip

echo "Installing GNOME extensions"
gnome-extensions install dash-to-dockmicxgx.gmail.com.v84.shell-extension.zip
gnome-extensions install apps-menugnome-shell-extensions.gcampax.github.com.v52.shell-extension.zip
gnome-extensions install VitalsCoreCoding.com.v61.shell-extension.zip
gnome-extensions install tactilelundal.io.v27.shell-extension.zip

echo "Cleaning up GNOME extension files"
rm dash-to-dockmicxgx.gmail.com.v84.shell-extension.zip
rm apps-menugnome-shell-extensions.gcampax.github.com.v52.shell-extension.zip
rm VitalsCoreCoding.com.v61.shell-extension.zip
rm tactilelundal.io.v27.shell-extension.zip

echo "Enabling GNOME extensions"
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gnome-extensions enable apps-menu@gnome-shell-extensions.gcampax.github.com

#echo "Setting wallpaper"
#gsettings set org.gnome.desktop.background picture-uri "file:///$WALLPAPERDIR//name.jpg"
#gsettings set org.gnome.desktop.background picture-uri-dark "file:///$WALLPAPERDIR//name.jpg"

#echo "Setting random wallpaper"
#WALLPAPER=$(ls $WALLPAPERDIR | shuf -n 1)
#gsettings set org.gnome.desktop.background picture-uri "file:///$WALLPAPERDIR//$WALLPAPER"
#gsettings set org.gnome.desktop.background picture-uri-dark "file:///$WALLPAPERDIR//$WALLPAPER"

echo "Configuring dash-to-dock"
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

echo "Configuring favorite-apps"
gsettings set org.gnome.shell favorite-apps "['firefox-esr.desktop', 'thunderbird.desktop', 'org.gnome.Terminal.desktop', 'code.desktop', 'org.qt-project.qtcreator.desktop', 'codeblocks.desktop', 'org.kde.kate.desktop', 'org.gnome.gedit.desktop', 'org.gnome.Calculator.desktop', 'github-desktop.desktop', 'cmake-gui.desktop', 'libreoffice-writer.desktop', 'org.gnome.Rhythmbox3.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Calendar.desktop', 'makemkv.desktop', 'virtualbox.desktop', 'org.gnome.Software.desktop', 'gufw.desktop']"

# Use the following the get your favorite apps list
#   gsettings get org.gnome.shell favorite-apps
