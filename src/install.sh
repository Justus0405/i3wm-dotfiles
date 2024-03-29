#!/bin/bash
export DIRMAIN=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" && pwd )
RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

echo -e "${GREEN}--------------------"
echo -e "Justus0405 dotfiles "
echo -e "Installer Ver. 1.1"
echo -e "Have a good day!"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

while true; do
    read -p "Continue installation? [Y/n] " yn
    case $yn in
        [Yy]* ) echo installing...; break;;
        [Nn]* ) echo exiting; exit;;
        * ) echo installing...; break;;
    esac
done

while true; do
    read -p "Set keyboard layout to German? [y/N] " yn
    case $yn in
        [Yy]* ) echo Setting keyboard layout to German...; sudo localectl set-keymap de; break;;
        [Nn]* ) echo Keeping current keyboard layout; break;;
        * ) echo Keeping current keyboard layout; break;;
    esac
done

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Installing apps..."
echo -e "--------------------${ENDCOLOR}"
echo -e ""

sudo pacman -S alacritty bash-completion code discord ffmpeg flameshot gimp gnome-color-manager gnu-free-fonts gst-libav gst-plugins-ugly gvfs gvfs-smb htop i3-wm lib32-pipewire loupe lxappearance-gtk3 nano neofetch network-manager-applet nitrogen obs-studio papirus-icon-theme pipewire pipewire-jack pipewire-pulse polybar qt5-graphicaleffects qt5-quickcontrols2 qt5-svg rofi rtkit sddm steam totem ttf-jetbrains-mono-nerd unzip wget wireplumber xf86-input-evdev xf86-input-synaptics yt-dlp

sudo usermod -a -G rtkit $USER

wget https://github.com/catppuccin/gtk/releases/download/v0.7.1/Catppuccin-Mocha-Standard-Mauve-Dark.zip -P $DIRMAIN/assets

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
        *) echo "invalid option $REPLY, skipping...";;
    esac
  break
done

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Copying files..."
echo -e "--------------------${ENDCOLOR}"
echo -e ""

mkdir -p ~/.config ~/.local/share/themes
unzip $DIRMAIN/assets/Catppuccin-Mocha-Standard-Mauve-Dark.zip -d ~/.local/share/themes/

echo -e "[xin_-1]\nfile=/home/$USER/.config/wallpaper.jpg\nmode=5\nbgcolor=#000000" > config/nitrogen/bg-saved.cfg
chmod +x $DIRMAIN/config/polybar/launch.sh
cp -r $DIRMAIN/config/* ~/.config/

sudo cp -r $DIRMAIN/assets/sddm/catppuccin-mocha /usr/share/sddm/themes/
sudo cp -r $DIRMAIN/assets/sddm.conf /etc/

sudo mv /usr/share/X11/xorg.conf.d/40-libinput.conf ~/.config/
sudo cp -r $DIRMAIN/assets/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Enabling services..."
echo -e "--------------------${ENDCOLOR}"
echo -e ""

systemctl --user enable pipewire pipewire-pulse
sudo systemctl enable NetworkManager
sudo systemctl disable gdm
sudo systemctl disable lightdm
sudo systemctl enable sddm

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
            git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm
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
        *) echo "invalid option $REPLY, skipping...";;
    esac
  break
done

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Finished! Rebooting..."
echo -e "--------------------${ENDCOLOR}"
echo -e ""

reboot
