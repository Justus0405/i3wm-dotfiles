#!/bin/bash

# Get main directory for variable install paths
export DIRMAIN=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" && pwd )

## Main Functions

# Starting Function
CONFIRM_INSTALLATION() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Catppuccin Dotfiles                              │
│ By Justus0405                                    │
│                                                  │
│ Installer Version 1.3                            │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	while true; do
		read -p "Continue installation? [Y/n] " yn
		case $yn in
			[Yy]* ) echo -e "Installing..."; break;;
			[Nn]* ) echo -e "Aborting!"; exit;;
			* ) echo -e "Installing..."; break;;
		esac
	done
}

# Function to determine the wanted edition
CHOOSE_PROFILE() {

	while true; do
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Choose your profile                              │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	echo -e "Choose your Edition:"
	echo -e "1) Minimal"
	echo -e "\tPackages : Window Manager, Login Manager, File Manager, Fonts, Icons, Audio, Input, Screenshots"
 	echo -e "\tBrowser  : Chromium"
  	echo -e "\tMedia    : none"
   	echo -e ""
	echo -e "2) Standard"
 	echo -e "\tPackages : Window Manager, Login Manager, File Manager, Fonts, Icons, Audio, Input, Screenshots,"
  	echo -e "\t\tCalculator, Disk Utility, Yay"
 	echo -e "\tBrowser  : Brave"
  	echo -e "\tMedia    : Totem, Loupe"
   	echo -e ""
	echo -e "3) Full"
	echo -e "\tPackages : Window Manager, Login Manager, File Manager, Fonts, Icons, Audio, Input, Screenshots,"
 	echo -e "\t\tCalculator, Disk Utility, Color Manager, ffmpeg, OBS, GIMP, Steam, Yay, VSCode, Vesktop, Prismlauncher, yt-dlp"
 	echo -e "\tBrowser  : Brave"
  	echo -e "\tMedia    : Totem, Loupe"
   	echo -e ""

	read -p "Your Choice: " choice

	case $choice in
		"1" | "minimal" | "Minimal")
			edition=0
			echo -e "Installing Minimal Edition"
			break
		;;
		"2" | "standard" | "Standard")
			edition=1
			echo -e "Installing Standard Edition"
			break
		;;
		"3" | "full" | "Full")
			edition=2
			echo -e "Installing Full Edition"
			break
		;;
		*)
			echo -e "Invalid Answer"
		;;
		esac
	done
}

# Function for choosing extras
CHOOSE_EXTRAS() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Choose extra settings                            │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	while true; do
		read -p "Add a Wifi Menu to the top bar? (Recommended for Laptops) [y/N] " yn
		case $yn in
			[Yy]* ) echo -e "Adding Wifi Menu..."; sudo pacman -S --needed --noconfirm network-manager-applet; echo -e ""; break;;
			[Nn]* ) echo -e "Skipping..."; echo -e ""; break;;
			* ) echo -e "Skipping..."; echo -e ""; break;;
		esac
	done

	while true; do
		read -p "Add Bluetooth support? [y/N] " yn
		case $yn in
			[Yy]* ) echo -e "Adding Bluetooth Menu..."; sudo pacman -S --needed --noconfirm bluez bluez-utils blueman; sudo systemctl enable bluetooth.service; echo -e ""; break;;
			[Nn]* ) echo -e "Skipping..."; echo -e ""; break;;
			* ) echo -e "Skipping..."; echo -e ""; break;;
		esac
	done
}

# Function for updating the host system
UPDATE_SYSTEM() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Updating System...                               │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	sudo pacman -Syyu || { echo -e "System update failed. Exiting."; exit; }

}

# Function for installing needed packages
INSTALL_PACKAGES() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Installing Packages...                           │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	# Pacman
	case $edition in
		0)
			# Minimal
			sudo pacman -S --needed alacritty bash-completion chromium flameshot gnu-free-fonts gst-plugin-pipewire i3-wm lib32-pipewire nemo nemo-audio-tab nemo-fileroller nemo-image-converter nemo-share nitrogen papirus-icon-theme pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse polybar qt5-graphicaleffects qt5-quickcontrols2 qt5-svg rofi rtkit sddm ttf-jetbrains-mono ttf-jetbrains-mono-nerd unzip wget wireplumber xf86-input-evdev xf86-input-synaptics
			sed -i 's/brave/chromium/g' $DIRMAIN/config/i3/config
		;;
		1)
			# Standard
			sudo pacman -S --needed alacritty bash-completion flameshot fuse gnome-calculator gnome-disk-utility gnome-text-editor gnu-free-fonts gst-libav gst-plugin-pipewire gst-plugins-ugly gvfs gvfs-smb htop i3-wm lib32-pipewire loupe lxappearance-gtk3 nano nemo nemo-audio-tab nemo-fileroller nemo-image-converter nemo-share neofetch nitrogen ntfs-3g pacman-contrib papirus-icon-theme pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse polybar qt5-graphicaleffects qt5-quickcontrols2 qt5-svg rofi rtkit sddm totem ttf-jetbrains-mono ttf-jetbrains-mono-nerd unzip wget wireplumber xf86-input-evdev xf86-input-synaptics
		;;
		2)
			# Full
			sudo pacman -S --needed alacritty bash-completion code ffmpeg flameshot fuse gimp gnome-calculator gnome-color-manager gnome-disk-utility gnome-text-editor gnu-free-fonts gst-libav gst-plugin-pipewire gst-plugins-ugly gvfs gvfs-smb htop i3-wm lib32-pipewire loupe lxappearance-gtk3 nano nemo nemo-audio-tab nemo-fileroller nemo-image-converter nemo-share neofetch nitrogen ntfs-3g nvtop obs-studio pacman-contrib papirus-icon-theme pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse polybar qt5-graphicaleffects qt5-quickcontrols2 qt5-svg rofi rtkit sddm steam totem ttf-jetbrains-mono ttf-jetbrains-mono-nerd unzip wget wireplumber xf86-input-evdev xf86-input-synaptics yt-dlp
		;;
	esac

	# Important for Pipewire
	sudo usermod -a -G rtkit $USER

	# Catppuccin Mocha Mauve Dark GTK Theme
	wget https://github.com/catppuccin/gtk/releases/download/v0.7.5/Catppuccin-Mocha-Standard-Mauve-Dark.zip -P $DIRMAIN/assets

	# Yay
	case $edition in
		1)
			cd $DIRMAIN
			git clone https://aur.archlinux.org/yay.git
			cd yay
			makepkg -si --noconfirm
			cd ..

			yay -S --noconfirm brave-bin
		;;
		2)
			cd $DIRMAIN
			git clone https://aur.archlinux.org/yay.git
			cd yay
			makepkg -si --noconfirm
			cd ..

			yay -S --noconfirm brave-bin
			yay -S --noconfirm vesktop-bin
			yay -S --noconfirm prismlauncher-qt5-bin
		;;
	esac
}

# Function for copying config files
COPY_FILES() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Copying Files...                                 │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	# GTK Theme
	mkdir -p ~/.config ~/.local/share/themes
	unzip $DIRMAIN/assets/Catppuccin-Mocha-Standard-Mauve-Dark.zip -d ~/.local/share/themes/

	# Nitrogen config
	echo -e "[xin_-1]\nfile=/home/$USER/.config/wallpapers/scenery.png\nmode=5\nbgcolor=#000000" > $DIRMAIN/config/nitrogen/bg-saved.cfg
	echo -e "[geometry]\n\n[nitrogen]\nview=list\nrecurse=true\nsort=alpha\nicon_caps=false\ndirs=/home/$USER/.config/wallpapers;" > $DIRMAIN/config/nitrogen/nitrogen.cfg

	# Polybar & .config
	chmod +x $DIRMAIN/config/polybar/launch.sh
	cp -r $DIRMAIN/config/* ~/.config/

	# SDDM Theme
	sudo cp -r $DIRMAIN/assets/sddm/catppuccin-mocha /usr/share/sddm/themes/
	sudo cp -r $DIRMAIN/assets/sddm.conf /etc/

	# xf86-input-evdev
	sudo mv /usr/share/X11/xorg.conf.d/40-libinput.conf ~/.config/
	sudo cp -r $DIRMAIN/assets/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/
}

# Function for enabling services
ENABLE_SERVICES() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Enabling Services...                             │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	systemctl --user enable pipewire pipewire-pulse
	sudo systemctl enable NetworkManager
	sudo systemctl disable gdm
	sudo systemctl disable lightdm
	sudo systemctl enable sddm
}

# Function for rebooting
FINISHED() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Installation Finished                            │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	echo -e "Rebooting in..."
	for i in {5..1}; do
		echo -e "$i"
		sleep 1
	done

	echo -e "Rebooting now!"
	sudo reboot now
}

# Step 1
CONFIRM_INSTALLATION
# Step 2
CHOOSE_PROFILE
# Step 3
CHOOSE_EXTRAS
# Step 4
UPDATE_SYSTEM
# Step 5
INSTALL_PACKAGES
# Step 6
COPY_FILES
# Step 7
ENABLE_SERVICES
# Step 8
FINISHED
