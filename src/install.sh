#!/bin/bash
export DIRMAIN=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" && pwd )

echo Version 1.0

sudo pacman -S pipewire lib32-pipewire pipewire-pulse pipewire-jack wireplumber rtkit i3-wm sddm polybar rofi alacritty nitrogen xf86-input-evdev xf86-input-synaptics pcmanfm-gtk3 xarchiver lxappearance-gtk3 neofetch flameshot unzip htop qt5-graphicaleffects qt5-svg qt5-quickcontrols2 wget gvfs gvfs-smb nano code loupe totem gst-libav gst-plugins-ugly ffmpeg yt-dlp discord steam obs-studio

sudo usermod -a -G rtkit $USER
systemctl --user enable pipewire pipewire-pulse

sudo localectl set-keymap de

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip -P $DIRMAIN/assets
wget https://github.com/catppuccin/gtk/releases/download/v0.7.1/Catppuccin-Mocha-Standard-Mauve-Dark.zip -P $DIRMAIN/assets

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

sudo systemctl enable sddm

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -S brave-bin

reboot
