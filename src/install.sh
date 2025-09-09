#!/bin/bash

# Get main directory for variable install paths
DIRMAIN=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

# //////////////////////////////////////////////////
#
# Confirmation Function
#
# //////////////////////////////////////////////////
confirmInstallation() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Catppuccin Dotfiles                              │
│ By Justus0405                                    │
│                                                  │
│ Installer Version 1.6                            │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	while true; do
		read -rp "Continue installation? [Y/n] " yn
		case "$yn" in
		[Nn])
			echo -e "Aborting!"
			exit 0
			;;
		*)
			echo -e "Installing..."
			break
			;;
		esac
	done
}

# //////////////////////////////////////////////////
#
# Choose Edition Function
#
# //////////////////////////////////////////////////
chooseProfile() {

	while true; do
		clear
		cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Choose your profile                              │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

		echo -e "╭─────────────────────────────────────────────────────────────────╮"
		echo -e "│ 1) Minimal                                                      │"
		echo -e "├─────────────────────────────────────────────────────────────────┤"
		echo -e "│ Packages : Window Manager, Login Manager, File Manager,         │"
		echo -e "│            Basic Fonts, Icons, Audio, Input, Screenshots        │"
		echo -e "│ Browser  : Chromium                                             │"
		echo -e "│ Media    : none                                                 │"
		echo -e "╰─────────────────────────────────────────────────────────────────╯"
		echo -e ""

		echo -e "╭─────────────────────────────────────────────────────────────────╮"
		echo -e "│ 2) Standard                                                     │"
		echo -e "├─────────────────────────────────────────────────────────────────┤"
		echo -e "│ Packages : Minimal+, Calculator, Disk Utility, Yay              │"
		echo -e "│                                                                 │"
		echo -e "│ Browser  : Brave                                                │"
		echo -e "│ Media    : Totem, Loupe                                         │"
		echo -e "╰─────────────────────────────────────────────────────────────────╯"
		echo -e ""

		echo -e "╭─────────────────────────────────────────────────────────────────╮"
		echo -e "│ 3) Full                                                         │"
		echo -e "├─────────────────────────────────────────────────────────────────┤"
		echo -e "│ Packages : Standard+, GIMP, Shotcut, Steam, Dev-Enviroment,     │"
		echo -e "│            Vesktop, Prismlauncher, CurseForge, r2modman, yt-dlp │"
		echo -e "│ Browser  : Brave                                                │"
		echo -e "│ Media    : Totem, Loupe                                         │"
		echo -e "╰─────────────────────────────────────────────────────────────────╯"
		echo -e ""

		read -rp "Your Choice: " choice

		case "$choice" in
		"1" | "minimal" | "Minimal")
			edition="0"
			echo -e "Installing Minimal Edition"
			break
			;;
		"2" | "standard" | "Standard")
			edition="1"
			echo -e "Installing Standard Edition"
			break
			;;
		"3" | "full" | "Full")
			edition="2"
			echo -e "Installing Full Edition"
			break
			;;
		*)
			echo -e "Invalid Answer"
			continue
			;;
		esac
	done
}

# //////////////////////////////////////////////////
#
# Update System Function
#
# //////////////////////////////////////////////////
updateSystem() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Updating System...                               │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	sudo pacman -Syyu --noconfirm || errorHandling 1

}

## //////////////////////////////////////////////////
#
# Install Packages Sub-Function
#
# //////////////////////////////////////////////////
installPackages() {
	local file="$1"
	sed '/^\s*#/d;/^\s*$/d' "$DIRMAIN/packages/$file" | sudo pacman -S --needed --noconfirm - || errorHandling 2
}

# //////////////////////////////////////////////////
#
# Install System using Pacman Function
#
# //////////////////////////////////////////////////
pacmanPackages() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Installing System Packages...                    │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	# Info message for right vulkan driver
	case "$edition" in
	"2")
		# Full
		echo -e ""
		echo -e "╭─────────────────────────────────────────────────────────────────╮"
		echo -e "│ Steam requires the usage of vulkan which needs a specific       │"
		echo -e "│ Driver you need to choose. The Open-Source variants are all     │"
		echo -e "│ part of the Mesa project                                        │"
		echo -e "├─────────────────────────────────────────────────────────────────┤"
		echo -e "│ Nvidia -> nvidia-utils            (Proprietary) (Recommended)   │"
		echo -e "│ Nvidia -> vulkan-nouveau          (Open-Source) (Slower)        │"
		echo -e "├─────────────────────────────────────────────────────────────────┤"
		echo -e "│ Amd    -> vulkan-radeon           (Open-Source) (Recommended)   │"
		echo -e "│ Amd    -> amdvlk                  (Proprietary) (Slower)        │"
		echo -e "├─────────────────────────────────────────────────────────────────┤"
		echo -e "│ Intel  -> vulkan-intel            (Open-Source) (Recommended)   │"
		echo -e "├─────────────────────────────────────────────────────────────────┤"
		echo -e "│ Virtual Machines -> vulkan-virtio (Open-Source) (Recommended)   │"
		echo -e "├─────────────────────────────────────────────────────────────────┤"
		echo -e "│ Software -> vulkan-swrast         (Open-Source) (Very Slow)     │"
		echo -e "╰─────────────────────────────────────────────────────────────────╯"
		echo -e ""
		;;
	esac

	# Pacman
	case "$edition" in
	"0")
		# Minimal
		installPackages "minimal.txt"
		sed -i 's/brave/chromium/g' "$DIRMAIN/config/i3/config"
		;;
	"1")
		# Standard
		installPackages "minimal.txt"
		installPackages "standard.txt"
		;;
	"2")
		# Full
		installPackages "minimal.txt"
		installPackages "standard.txt"
		installPackages "full.txt"
		;;
	esac

	# Important for Pipewire
	sudo usermod -a -G rtkit "$USER"
}

# //////////////////////////////////////////////////
#
# Install Yay Sub-Function
#
# //////////////////////////////////////////////////
installYay() {
	cd "$DIRMAIN" || exit 1
	git clone https://aur.archlinux.org/yay.git
	cd yay || exit 1
	makepkg -si --noconfirm
	cd "$DIRMAIN" || exit 1
}

# //////////////////////////////////////////////////
#
# Install Yay Packages Function
#
# //////////////////////////////////////////////////
yayPackages() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Installing Yay and Packages...                   │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	case "$edition" in
	"1")
		installYay

		# Install yay packages
		yay -S --noconfirm brave-bin catnap-git
		;;
	"2")
		installYay

		# Install yay packages
		yay -S --noconfirm brave-bin catnap-git vscodium-bin vesktop-bin r2modman-appimage curseforge gpu-screen-recorder
		;;
	esac
}

# //////////////////////////////////////////////////
#
# Choose Input Drivers Function
#
# //////////////////////////////////////////////////
chooseInput() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Choose input settings                            │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	while true; do
		read -rp "Please choose your keyboard layout ('us' or 'de' for Desktop, 'de-latin1' for Laptops): " layout
		if sudo localectl set-keymap "$layout"; then
			break
		else
			echo -e "${layout} is not a valid keyboard layout"
		fi
	done
	echo -e ""

	echo -e "╭───────────────────────────────────────────╮"
	echo -e "│ Please choose your preffered input driver │"
	echo -e "├───────────────────────┬───────────────────┴───────────────────────────────────────╮"
	echo -e "│ 1: libinput (Default) │ Best hardware support, variable sensitivity, High Latency │"
	echo -e "├───────────────────────┼───────────────────────────────────────────────────────────┤"
	echo -e "│ 2: xf86-input-evdev   │ Lowest Latency, limited support, no sensitivity setting   │"
	echo -e "╰───────────────────────┴───────────────────────────────────────────────────────────╯"
	echo -e ""
	while true; do
		read -rp "Your Choice: " choice

		case "$choice" in
		"1" | "libinput" | "Libinput" | "default" | "Default")
			echo -e "You chose libinput"
			break
			;;
		"2" | "xf86-input-evdev")
			echo -e "You chose xf86-input-evdev"
			mkdir -p "$HOME/.config"
			sudo mv "/usr/share/X11/xorg.conf.d/40-libinput.conf" "$HOME/.config/"
			sudo cp -r "$DIRMAIN/assets/xf86-input-evdev/50-mouse-acceleration.conf" "/etc/X11/xorg.conf.d/"
			break
			;;
		*)
			echo -e "Invalid Answer"
			continue
			;;
		esac
	done
}

# //////////////////////////////////////////////////
#
# Choose Extras Function
#
# //////////////////////////////////////////////////
chooseExtras() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Choose extra settings                            │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	while true; do
		read -rp "Add a Wifi Menu to the top bar? (Recommended for Laptops) [y/N] " yn
		case "$yn" in
		[Yy])
			echo -e "Adding Wifi Menu..."
			sudo pacman -S --needed --noconfirm network-manager-applet
			break
			;;
		*)
			echo -e "Skipping..."
			break
			;;
		esac
	done
	echo -e ""

	while true; do
		read -rp "Add Bluetooth support? [y/N] " yn
		case "$yn" in
		[Yy])
			echo -e "Adding Bluetooth Menu..."
			sudo pacman -S --needed --noconfirm bluez bluez-utils blueman
			sudo systemctl enable bluetooth.service
			break
			;;
		*)
			echo -e "Skipping..."
			break
			;;
		esac
	done
	echo -e ""

	while true; do
		read -rp "Set CPU Governor to performance? (powersave by default) [y/N] " yn
		case "$yn" in
		[Yy])
			echo -e "Setting CPU Governor to performance..."
			sudo pacman -S --needed --noconfirm cpupower
			echo "governor='performance'" | sudo tee /etc/default/cpupower
			sudo systemctl enable cpupower --now
			break
			;;
		*)
			echo -e "Skipping..."
			break
			;;
		esac
	done
	echo -e ""
}

# //////////////////////////////////////////////////
#
# Copy Config Files and Themes Function
#
# //////////////////////////////////////////////////
copyFiles() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Copying Files...                                 │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	# Create directories
	mkdir -p "$HOME/.config" "$HOME/.local/share/themes" "$HOME/.local/share/PrismLauncher/themes"

	# GTK and Prismlauncher themes
	unzip -o "$DIRMAIN/assets/gtk/catppuccin-mocha-mauve-standard+default.zip" -d "$HOME/.local/share/themes/" || errorHandling 3
	unzip -o "$DIRMAIN/assets/gtk/gtk-4.0.zip" -d "$HOME/.config/" || errorHandling 3
	unzip -o "$DIRMAIN/assets/prismlauncher/Prismlauncher-themes.zip" -d "$HOME/.local/share/PrismLauncher/themes/" || errorHandling 3

	# Nitrogen config
	echo -e "[xin_-1]\nfile=/home/$USER/.config/wallpapers/cloudy_crescent.png\nmode=5\nbgcolor=#000000" >"$DIRMAIN/config/nitrogen/bg-saved.cfg"
	echo -e "[geometry]\n\n[nitrogen]\nview=list\nrecurse=true\nsort=alpha\nicon_caps=false\ndirs=/home/$USER/.config/wallpapers;" >"$DIRMAIN/config/nitrogen/nitrogen.cfg"

	# Permissions & .config
	chmod +x "$DIRMAIN/config/polybar/launch.sh"
	chmod +x "$DIRMAIN/config/rofi/scripts/"*
	cp -r "$DIRMAIN"/config/* "$HOME/.config/"

	# SDDM Theme
	sudo unzip -o "$DIRMAIN/assets/sddm/catppuccin-mocha.zip" -d "/usr/share/sddm/themes/" || errorHandling 3
	sudo cp -r "$DIRMAIN/assets/sddm/sddm.conf" "/etc/"

	# Nemo scripts & config
	gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty
	gsettings set org.nemo.icon-view default-zoom-level 'larger'
	mkdir -p "$HOME/.local/share/nemo/scripts/"
	cp -r "$DIRMAIN/assets/nemo/"* "$HOME/.local/share/nemo/scripts/"

	# Bashrc
	case "$edition" in
	"1")
		# Standard
		echo "catnap" >>"$HOME/.bashrc"
		;;
	"2")
		# Full
		echo "catnap" >>"$HOME/.bashrc"
		;;
	esac
}

# //////////////////////////////////////////////////
#
# Enable Services Function
#
# //////////////////////////////////////////////////
enableServices() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Enabling Services...                             │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	systemctl --user enable pipewire pipewire-pulse wireplumber
	sudo systemctl enable systemd-timesyncd --now
	sudo systemctl enable fstrim.timer
	sudo systemctl enable NetworkManager
	sudo systemctl disable gdm
	sudo systemctl disable lightdm
	sudo systemctl enable sddm
}

# //////////////////////////////////////////////////
#
# Reboot Prompt Function
#
# //////////////////////////////////////////////////
finished() {
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

# //////////////////////////////////////////////////
#
# Error Handling Function (Experimental)
#
# //////////////////////////////////////////////////
errorHandling() {
	case "$1" in
	"1")
		echo -e "Error: System update failed. Exiting."
		;;
	"2")
		echo -e "Error: couldnt install packages. Do you have your package manager configured correctly?"
		;;
	"3")
		echo -e "Error: couldnt unzip assets. Do you have your package manager configured correctly?"
		;;
	*)
		echo -e "Error: Unexpected issue."
		;;
	esac
	exit 1
}

# //////////////////////////////////////////////////
#
# PROGRAM START
#
# //////////////////////////////////////////////////

# Step 1: Set up trap for SIGINT (CTRL+C)
trap 'echo -e "Exited"; exit 0' SIGINT

# Step 2
confirmInstallation

# Step 3
chooseProfile

# Step 4
updateSystem

# Step 5
pacmanPackages

# Step 6
yayPackages

# Step 7
chooseInput

# Step 8
chooseExtras

# Step 9
copyFiles

# Step 10
enableServices

# Step 11
finished
