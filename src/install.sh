#!/bin/bash
export DIRMAIN=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" && pwd )

echo Version 1.0

sudo pacman -S pipewire lib32-pipewire pipewire-pulse pipewire-jack wireplumber rtkit i3-wm sddm polybar rofi alacritty nitrogen xf86-input-evdev pcmanfm-gtk3 lxappearance-gtk3 neofetch flameshot unzip qt5-graphicaleffects qt5-svg qt5-quickcontrols2 wget nano code discord steam 

sudo usermod -a -G rtkit $USER
systemctl --user enable pipewire pipewire-pulse

sudo localectl set-keymap de

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip -P $DIRMAIN/assets
wget https://github.com/catppuccin/gtk/releases/download/v0.7.1/Catppuccin-Mocha-Standard-Mauve-Dark.zip -P $DIRMAIN/assets

mkdir -p ~/.config ~/.local/share/fonts ~/.local/share/themes
unzip $DIRMAIN/assets/Catppuccin-Mocha-Standard-Mauve-Dark.zip -d ~/.local/share/themes/
unzip $DIRMAIN/assets/JetBrainsMono.zip -d ~/.local/share/fonts/

cp -r $DIRMAIN/config/* ~/.config/

sudo cp -r $DIRMAIN/assets/sddm/catppuccin-mocha /usr/share/sddm/themes/
sudo cp -r $DIRMAIN/assets/sddm.conf /etc/

sudo mv /usr/share/X11/xorg.conf.d/40-libinput.conf ~/.config/
sudo cp -r $DIRMAIN/assets/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/

nitrogen --set-zoom-fill ~/.config/background.jpg

sudo systemctl enable sddm

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -S brave-bin

reboot
