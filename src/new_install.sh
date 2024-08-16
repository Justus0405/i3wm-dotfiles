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
			[Yy]* ) echo Installing...; break;;
			[Nn]* ) echo Aborting!; exit;;
			* ) echo Installing...; break;;
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
	echo -e "2) Standard"
	echo -e "3) Full"

	read -p "Your Choice: " choice

	case $choice in
		"1" | "minimal" | "Minimal")
			edition=0
			echo "Installing Minimal Edition"
			break
		;;
		"2" | "standard" | "Standard")
			edition=1
			echo "Installing Standard Edition"
			break
		;;
		"3" | "full" | "Full")
			edition=2
			echo "Installing Full Edition"
			break
		;;
		*)
			echo "Invalid Answer"
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
			[Yy]* ) echo Adding Wifi Menu...; sudo pacman -S network-manager-applet --noconfirm; echo ""; break;;
			[Nn]* ) echo Skipping...; echo ""; break;;
			* ) echo Skipping...; echo ""; break;;
		esac
	done

	while true; do
		read -p "Add Bluetooth support? [y/N] " yn
		case $yn in
			[Yy]* ) echo Adding Bluetooth Menu...; sudo pacman -S bluez bluez-utils blueman --noconfirm; sudo systemctl enable bluetooth.service; echo ""; break;;
			[Nn]* ) echo Skipping...; echo ""; break;;
			* ) echo Skipping...; echo ""; break;;
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

	sudo pacman -Syyu || { echo "System update failed. Exiting."; exit; }

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
			makepkg -si
			cd ..

			yay -S brave-bin --noconfirm
		;;
		2)
			cd $DIRMAIN
			git clone https://aur.archlinux.org/yay.git
			cd yay
			makepkg -si
			cd ..

			yay -S brave-bin --noconfirm
			yay -S vesktop-bin --noconfirm
			yay -S prismlauncher-qt5-bin --noconfirm
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
	sudo mkdir -p ~/.config ~/.local/share/themes
	sudo unzip $DIRMAIN/assets/Catppuccin-Mocha-Standard-Mauve-Dark.zip -d ~/.local/share/themes/

	# Nitrogen config
	echo -e "[xin_-1]\nfile=/home/$USER/.config/wallpapers/scenery.png\nmode=5\nbgcolor=#000000" > $DIRMAIN/config/nitrogen/bg-saved.cfg
	echo -e "[geometry]\n\n[nitrogen]\nview=list\nrecurse=true\nsort=alpha\nicon_caps=false\ndirs=/home/$USER/.config/wallpapers;" > $DIRMAIN/config/nitrogen/nitrogen.cfg

	# Polybar & .config
	sudo chmod +x $DIRMAIN/config/polybar/launch.sh
	sudo cp -r $DIRMAIN/config/* ~/.config/

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
		echo "$i"
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
