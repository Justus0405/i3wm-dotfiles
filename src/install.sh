#!/bin/bash
clear

export DIRMAIN=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" && pwd )
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

echo -e "${BLUE}"
cat <<"EOF"
+-------------------------------------------------------+
|   ____      _                              _          |
|  / ___|__ _| |_ _ __  _ __  _   _  ___ ___(_)_ __     |
| | |   / _` | __| '_ \| '_ \| | | |/ __/ __| | '_ \    |
| | |__| (_| | |_| |_) | |_) | |_| | (_| (__| | | | |   |
|  \____\__,_|\__| .__/| .__/ \__,_|\___\___|_|_| |_|   |
|  ____        _ |_|__ |_|                              |
| |  _ \  ___ | |_ / _(_) | ___  ___                    |
| | | | |/ _ \| __| |_| | |/ _ \/ __|                   |
| | |_| | (_) | |_|  _| | |  __/\__ \                   |
| |____/ \___/ \__|_| |_|_|\___||___/                   |
|                                                       |
+-------------------------------------------------------+
EOF
echo -e "${BLUE}|${ENDCOLOR}                                                       ${BLUE}|"
echo -e "${BLUE}|${ENDCOLOR} Version: 1.2                                          ${BLUE}|"
echo -e "${BLUE}|${ENDCOLOR} By Justus0405                                         ${BLUE}|"
echo -e "${BLUE}|${ENDCOLOR}                                                       ${BLUE}|"
echo -e "${BLUE}+-------------------------------------------------------+"
echo -e "${ENDCOLOR}"

while true; do
    read -p "Continue installation? [Y/n] " yn
    case $yn in
        [Yy]* ) echo installing...; break;;
        [Nn]* ) exit;;
        * ) echo installing...; break;;
    esac
done

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Updating System"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

sudo pacman -Syyu --noconfirm

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Installing apps"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

sudo pacman -Syy alacritty bash-completion code discord ffmpeg flameshot fuse gimp gnome-calculator gnome-color-manager gnome-disk-utility gnome-text-editor gnu-free-fonts gst-libav gst-plugin-pipewire gst-plugins-ugly gvfs gvfs-smb htop i3-wm lib32-pipewire loupe lxappearance-gtk3 nano neofetch nitrogen ntfs-3g nvtop obs-studio pacman-contrib papirus-icon-theme pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse polybar qt5-graphicaleffects qt5-quickcontrols2 qt5-svg rofi rtkit sddm steam totem ttf-jetbrains-mono ttf-jetbrains-mono-nerd unzip wget wireplumber xf86-input-evdev xf86-input-synaptics yt-dlp

sudo usermod -a -G rtkit $USER

wget https://github.com/catppuccin/gtk/releases/download/v0.7.5/Catppuccin-Mocha-Standard-Mauve-Dark.zip -P $DIRMAIN/assets

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Installing yay"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Choosing experience"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

while true; do
    read -p "Set keyboard layout to German? [y/N] " yn
    case $yn in
        [Yy]* ) echo Setting keyboard layout to German...; sudo localectl set-keymap de; break;;
        [Nn]* ) echo Keeping current keyboard layout; break;;
        * ) echo Keeping current keyboard layout; break;;
    esac
done

while true; do
    read -p "Add a Wifi Menu to the top bar? (Recommended for Laptops) [y/N] " yn
    case $yn in
        [Yy]* ) echo Adding Wifi Menu...; sudo pacman -S network-manager-applet --noconfirm; break;;
        [Nn]* ) echo Skipping...; break;;
        * ) echo Skipping...; break;;
    esac
done

while true; do
    read -p "Add Bluetooth support? [y/N] " yn
    case $yn in
        [Yy]* ) echo Adding Bluetooth Menu...; sudo pacman -S bluez bluez-utils blueman --noconfirm; sudo systemctl enable bluetooth.service; break;;
        [Nn]* ) echo Skipping...; break;;
        * ) echo Skipping...; break;;
    esac
done

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Choosing a Filemanager"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

PS3='Type in the NUMBER of your Filemanager: '
filemanagers=("Nemo" "Pcmanfm-gtk3" "Nautilus" "Skip")
select fav1 in "${filemanagers[@]}"; do
    case $fav1 in
        "Nemo")
            sudo pacman -S nemo nemo-audio-tab nemo-fileroller nemo-image-converter nemo-share --noconfirm
	    break
            ;;
        "Pcmanfm-gtk3")
            sudo pacman -S pcmanfm-gtk3 xarchiver --noconfirm
	    break
            ;;
        "Nautilus")
            sudo pacman -S nautilus nautilus-image-converter nautilus-share --noconfirm
	    break
            ;;
	"Skip")
	    echo "Skipping..."
	    break
	    ;;
        *) echo "invalid option $REPLY";;
    esac
  break
done

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Choosing a Browser"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

PS3='Type in the NUMBER of your browser: '
browsers=("Brave" "Chromium" "Firefox" "Skip")
select fav2 in "${browsers[@]}"; do
    case $fav2 in
        "Brave")
            yay -S brave-bin --noconfirm
	    break
            ;;
        "Chromium")
            sudo pacman -S chromium --noconfirm
	    break
            ;;
        "Firefox")
            sudo pacman -S firefox --noconfirm
	    break
            ;;
	"Skip")
	    echo "Skipping..."
	    break
	    ;;
        *) echo "invalid option $REPLY";;
    esac
  break
done

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Copying files"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

mkdir -p ~/.config ~/.local/share/themes
unzip $DIRMAIN/assets/Catppuccin-Mocha-Standard-Mauve-Dark.zip -d ~/.local/share/themes/

echo -e "[xin_-1]\nfile=/home/$USER/.config/wallpapers/scenery.png\nmode=5\nbgcolor=#000000" > $DIRMAIN/config/nitrogen/bg-saved.cfg
chmod +x $DIRMAIN/config/polybar/launch.sh
cp -r $DIRMAIN/config/* ~/.config/

sudo cp -r $DIRMAIN/assets/sddm/catppuccin-mocha /usr/share/sddm/themes/
sudo cp -r $DIRMAIN/assets/sddm.conf /etc/

sudo mv /usr/share/X11/xorg.conf.d/40-libinput.conf ~/.config/
sudo cp -r $DIRMAIN/assets/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Enabling services"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

systemctl --user enable pipewire pipewire-pulse
sudo systemctl enable NetworkManager
sudo systemctl disable gdm
sudo systemctl disable lightdm
sudo systemctl enable sddm

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Finished! Rebooting"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

reboot
