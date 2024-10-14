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
	echo -e "\tPackages : Window Manager, Login Manager, File Manager, Basic Fonts, Icons, Audio, Input, Screenshots"
 	echo -e "\tBrowser  : Chromium"
  	echo -e "\tMedia    : none"
   	echo -e ""
	echo -e "2) Standard"
 	echo -e "\tPackages : Window Manager, Login Manager, File Manager, Full Fonts, Icons, Audio, Input, Screenshots,"
  	echo -e "\t           Calculator, Disk Utility, Yay"
 	echo -e "\tBrowser  : Brave"
  	echo -e "\tMedia    : Totem, Loupe"
   	echo -e ""
	echo -e "3) Full"
	echo -e "\tPackages : Window Manager, Login Manager, File Manager, Full Fonts, Icons, Audio, Input, Screenshots,"
 	echo -e "\t           Calculator, Disk Utility, Yay, Color Manager, ffmpeg, OBS, GIMP, Steam, VSCode, Vesktop,"
	echo -e "\t           Prismlauncher, Curseforge, r2modman, Spotify, IntelliJ, yt-dlp"
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

# Pacman Packages
minimal="alacritty bash-completion chromium flameshot gnu-free-fonts gst-plugin-pipewire i3-wm lib32-pipewire nemo nemo-audio-tab nemo-fileroller nemo-image-converter nemo-share nitrogen papirus-icon-theme pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse polybar qt5-graphicaleffects qt5-quickcontrols2 qt5-svg rofi rtkit sddm ttf-jetbrains-mono ttf-jetbrains-mono-nerd unzip wget wireplumber xf86-input-evdev xf86-input-synaptics"

standard="fuse gnome-calculator gnome-disk-utility gnome-text-editor gst-libav gst-plugins-ugly gvfs gvfs-smb htop loupe lxappearance-gtk3 nano noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra ntfs-3g pacman-contrib totem"

full="code ffmpeg gimp gnome-color-manager intellij-idea-community-edition jdk17-openjdk jdk21-openjdk jdk8-openjdk nvtop obs-studio pavucontrol resources steam yt-dlp"

	# Pacman
	case $edition in
		0)
			# Minimal
			sudo pacman -S --needed $minimal
   			sed -i 's/brave/chromium/g' $DIRMAIN/config/i3/config
		;;
		1)
			# Standard
			sudo pacman -S --needed $minimal $standard
		;;
		2)
			# Full
			sudo pacman -S --needed $minimal $standard $full
		;;
	esac

	# Important for Pipewire
	sudo usermod -a -G rtkit $USER

# Yay Packages
yay_standard="brave-bin catnap-git"

yay_full="prismlauncher-qt5-bin vesktop-bin r2modman-appimage curseforge"

	# Yay
	case $edition in
		1)
			cd $DIRMAIN
			git clone https://aur.archlinux.org/yay.git
			cd yay
			makepkg -si --noconfirm
			cd ..

			yay -S --noconfirm $yay_standard
		;;
		2)
			cd $DIRMAIN
			git clone https://aur.archlinux.org/yay.git
			cd yay
			makepkg -si --noconfirm
			cd ..

			yay -S --noconfirm $yay_standard $yay_full
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

	# Create directories
	mkdir -p ~/.config ~/.local/share/themes

 	# GTK and other Themes
	unzip $DIRMAIN/assets/Catppuccin-Mocha-Standard-Mauve-Dark.zip -d ~/.local/share/themes/
 	cp -r $DIRMAIN/local/* ~/.local/

	# Nitrogen config
	echo -e "[xin_-1]\nfile=/home/$USER/.config/wallpapers/rocket_launch.png\nmode=5\nbgcolor=#000000" > $DIRMAIN/config/nitrogen/bg-saved.cfg
	echo -e "[geometry]\n\n[nitrogen]\nview=list\nrecurse=true\nsort=alpha\nicon_caps=false\ndirs=/home/$USER/.config/wallpapers;" > $DIRMAIN/config/nitrogen/nitrogen.cfg

	# Polybar & .config
	chmod +x $DIRMAIN/config/polybar/launch.sh
	cp -r $DIRMAIN/config/* ~/.config/

	# SDDM Theme
	sudo unzip $DIRMAIN/assets/catppuccin-mocha.zip -d /usr/share/sddm/themes/
	sudo cp -r $DIRMAIN/assets/sddm.conf /etc/

	# xf86-input-evdev
	sudo mv /usr/share/X11/xorg.conf.d/40-libinput.conf ~/.config/
	sudo cp -r $DIRMAIN/assets/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/

 	# Bashrc
  	case $edition in
		1)
			# Standard
			echo "catnap" >> ~/.bashrc
		;;
		2)
			# Full
			echo "catnap" >> ~/.bashrc
		;;
	esac
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

	systemctl --user enable pipewire pipewire-pulse wireplumber
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
