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

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Installing apps..."
echo -e "--------------------${ENDCOLOR}"
echo -e ""

sudo pacman -S pipewire lib32-pipewire pipewire-pulse pipewire-jack wireplumber rtkit i3-wm sddm polybar rofi alacritty nitrogen xf86-input-evdev xf86-input-synaptics pcmanfm-gtk3 xarchiver lxappearance-gtk3 neofetch flameshot unzip htop qt5-graphicaleffects qt5-svg qt5-quickcontrols2 wget gvfs gvfs-smb nano code loupe totem gst-libav gst-plugins-ugly gnome-color-manager ffmpeg yt-dlp discord steam obs-studio gimp

sudo usermod -a -G rtkit $USER
sudo localectl set-keymap de

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip -P $DIRMAIN/assets
wget https://github.com/catppuccin/gtk/releases/download/v0.7.1/Catppuccin-Mocha-Standard-Mauve-Dark.zip -P $DIRMAIN/assets

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Copying files..."
echo -e "--------------------${ENDCOLOR}"
echo -e ""

mkdir -p ~/.config ~/.local/share/fonts ~/.local/share/themes
unzip $DIRMAIN/assets/Catppuccin-Mocha-Standard-Mauve-Dark.zip -d ~/.local/share/themes/
unzip $DIRMAIN/assets/JetBrainsMono.zip -d ~/.local/share/fonts/

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
sudo systemctl disable gdm
sudo systemctl disable lightdm
sudo systemctl enable sddm

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Choosing a Browser"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

PS3='Choose your browser: '
browsers=("Brave" "Chromium" "Firefox" "Skip")
select fav in "${browsers[@]}"; do
    case $fav in
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
