#!/usr/bin/env bash
#
# Automated dotfiles installer
#
# Author: Justus0405
# Date: 04.03.2024
# License: MIT

export scriptVersion="1.7"

### COLOR CODES ###
export black="\e[1;30m"
export red="\e[1;31m"
export green="\e[1;32m"
export yellow="\e[1;33m"
export blue="\e[1;34m"
export purple="\e[1;35m"
export cyan="\e[1;36m"
export lightGray="\e[1;37m"
export gray="\e[1;90m"
export lightRed="\e[1;91m"
export lightGreen="\e[1;92m"
export lightYellow="\e[1;93m"
export lightBlue="\e[1;94m"
export lightPurple="\e[1;95m"
export lightCyan="\e[1;96m"
export white="\e[1;97m"
export bold="\e[1m"
export faint="\e[2m"
export italic="\e[3m"
export underlined="\e[4m"
export blinking="\e[5m"
export reset="\e[0m"

### FUNCTIONS ###
confirmInstallation() {
	# Simple banner and ask for confirmation.

	clear
	cat <<"EOF"
┌──────────────────────────────────────────────────┐
│                                                  │
│ Catppuccin Dotfiles                              │
│ By Justus0405                                    │
│                                                  │
│ Installer Version 1.7                            │
│                                                  │
└──────────────────────────────────────────────────┘

EOF

	while true; do
		read -rp "Continue installation? [Y/n] " confirm
		case "${confirm}" in
		[Nn])
			exitScript "Aborted!"
			;;
		*)
			echo -e "Installing..."
			break
			;;
		esac
	done
}

chooseProfile() {
	# Lets the user decide between minimal, standard and Full profile.
	# Each profile builds upon the previous one.

	while true; do
		clear
		cat <<"EOF"
┌──────────────────────────────────────────────────┐
│                                                  │
│ Choose your profile                              │
│                                                  │
└──────────────────────────────────────────────────┘

EOF

		echo -e "┌─────────────────────────────────────────────────────────────────┐"
		echo -e "│ 1) Minimal                                                      │"
		echo -e "├─────────────────────────────────────────────────────────────────┤"
		echo -e "│ Packages : Window Manager, Login Manager, File Manager,         │"
		echo -e "│            Basic Fonts, Icons, Audio, Input, Screenshots        │"
		echo -e "│ Browser  : Chromium                                             │"
		echo -e "│ Media    : none                                                 │"
		echo -e "└─────────────────────────────────────────────────────────────────┘"
		echo -e ""

		echo -e "┌─────────────────────────────────────────────────────────────────┐"
		echo -e "│ 2) Standard                                                     │"
		echo -e "├─────────────────────────────────────────────────────────────────┤"
		echo -e "│ Packages : Minimal+, Calculator, Disk Utility, Yay              │"
		echo -e "│                                                                 │"
		echo -e "│ Browser  : Brave                                                │"
		echo -e "│ Media    : Totem, Loupe                                         │"
		echo -e "└─────────────────────────────────────────────────────────────────┘"
		echo -e ""

		echo -e "┌─────────────────────────────────────────────────────────────────┐"
		echo -e "│ 3) Full                                                         │"
		echo -e "├─────────────────────────────────────────────────────────────────┤"
		echo -e "│ Packages : Standard+, GIMP, Shotcut, Steam, Dev-Enviroment,     │"
		echo -e "│            Vesktop, Prismlauncher, CurseForge, r2modman, yt-dlp │"
		echo -e "│ Browser  : Brave                                                │"
		echo -e "│ Media    : Totem, Loupe                                         │"
		echo -e "└─────────────────────────────────────────────────────────────────┘"
		echo -e ""

		read -rp "Your Choice: " choice

		case "${choice}" in
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

updateSystem() {
	# Tries to update the system, if it fails send error code 1 to errorHandling().

	clear
	cat <<"EOF"
┌──────────────────────────────────────────────────┐
│                                                  │
│ Updating System...                               │
│                                                  │
└──────────────────────────────────────────────────┘

EOF

	sudo pacman -Syyu --noconfirm || errorHandling 1

}

installPackages() {
	# Installs the packages inside the txt file provided in the packages/ directory.

	local file="$1"
	if [[ ${file} == "full.txt" ]]; then
		# Vulkan driver table because of steam.

		echo -e ""
		echo -e "┌─────────────────────────────────────────────────────────────────┐"
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
		echo -e "└─────────────────────────────────────────────────────────────────┘"
		echo -e ""
		sed '/^\s*#/d;/^\s*$/d' "${directory}/packages/${file}" | sudo pacman -S --needed - || errorHandling 2
	else
		sed '/^\s*#/d;/^\s*$/d' "${directory}/packages/${file}" | sudo pacman -S --needed --noconfirm - || errorHandling 2
	fi
}

pacmanPackages() {
	# Handles installing the packages for each edition.

	clear
	cat <<"EOF"
┌──────────────────────────────────────────────────┐
│                                                  │
│ Installing System Packages...                    │
│                                                  │
└──────────────────────────────────────────────────┘

EOF

	# Pacman packages.
	case "${edition}" in
	"0")
		# Minimal
		installPackages "minimal.txt"
		# Change super + b from brave to chromium.
		sed -i 's/brave/chromium/g' "${directory}/config/i3/config"
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

	# Important for Pipewire.
	sudo usermod -a -G rtkit "${USER}"
}

checkAurHelper() {
	# Checks if yay is installed.

	if ! command -v yay >/dev/null 2>&1; then
		installAurHelper
	fi
}

installAurHelper() {
	# Installs yay from source.

	cd "/tmp" || exit 1
	git clone https://aur.archlinux.org/yay.git
	cd yay || exit 1
	makepkg -si --noconfirm
	cd "${directory}" || exit 1
}

aurPackages() {
	# Install aur packages for the standard and full edition.

	clear
	cat <<"EOF"
┌──────────────────────────────────────────────────┐
│                                                  │
│ Installing AUR packages...                       │
│                                                  │
└──────────────────────────────────────────────────┘

EOF

	case "${edition}" in
	"1")
		checkAurHelper

		# Install aur packages for the standard edition.
		yay -S --noconfirm brave-bin
		;;
	"2")
		checkAurHelper

		# Install aur packages for the full edition.
		yay -S --noconfirm brave-bin vscodium-bin vesktop-bin r2modman-appimage curseforge gpu-screen-recorder
		;;
	esac
}

chooseInput() {
	# Lets the user pick their preffered keyboard layout and input driver.

	clear
	cat <<"EOF"
┌──────────────────────────────────────────────────┐
│                                                  │
│ Choose input settings                            │
│                                                  │
└──────────────────────────────────────────────────┘

EOF

	while true; do
		read -rp "Please choose your keyboard layout ('us' or 'de' for Desktop, 'de-latin1' for Laptops): " layout
		if sudo localectl set-keymap "${layout}"; then
			break
		else
			echo -e "${layout} is not a valid keyboard layout"
		fi
	done
	echo -e ""

	echo -e "┌───────────────────────────────────────────┐"
	echo -e "│ Please choose your preffered input driver │"
	echo -e "├───────────────────────┬───────────────────┴───────────────────────────────────────┐"
	echo -e "│ 1: libinput (Default) │ Best hardware support, variable sensitivity, High Latency │"
	echo -e "├───────────────────────┼───────────────────────────────────────────────────────────┤"
	echo -e "│ 2: xf86-input-evdev   │ Lowest Latency, limited support, no sensitivity setting   │"
	echo -e "└───────────────────────┴───────────────────────────────────────────────────────────┘"
	echo -e ""
	while true; do
		read -rp "Your Choice: " choice

		case "${choice}" in
		"1" | "libinput" | "Libinput" | "default" | "Default")
			echo -e "You chose libinput"
			break
			;;
		"2" | "xf86-input-evdev" | "xf86" | "evdev")
			echo -e "You chose xf86-input-evdev"
			mkdir -p "${HOME}/.config"
			sudo mv "/usr/share/X11/xorg.conf.d/40-libinput.conf" "${HOME}/.config/"
			sudo cp -r "${directory}/assets/xf86-input-evdev/50-mouse-acceleration.conf" "/etc/X11/xorg.conf.d/"
			break
			;;
		*)
			echo -e "Invalid Answer"
			continue
			;;
		esac
	done
}

chooseExtras() {
	# Let the user choose additional settings like
	# a network tray icon, Bluetooth support and CPU performance mode.

	clear
	cat <<"EOF"
┌──────────────────────────────────────────────────┐
│                                                  │
│ Choose extra settings                            │
│                                                  │
└──────────────────────────────────────────────────┘

EOF

	while true; do
		read -rp "Add a Wifi Menu to the top bar? (Recommended for Laptops) [y/N] " option
		case "${option}" in
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
		read -rp "Add Bluetooth support? [y/N] " option
		case "${option}" in
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
		read -rp "Set CPU Governor to performance? (does not work in VMs) [y/N] " option
		case "${option}" in
		[Yy])
			echo -e "Setting CPU Governor to performance..."
			sudo pacman -S --needed --noconfirm cpupower
			echo "governor='performance'" | sudo tee "/etc/default/cpupower"
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

copyFiles() {
	# Copies all configuration files to their relevant paths.

	clear
	cat <<"EOF"
┌──────────────────────────────────────────────────┐
│                                                  │
│ Copying Files...                                 │
│                                                  │
└──────────────────────────────────────────────────┘

EOF

	# Create directories
	mkdir -p "${HOME}/.config" "${HOME}/.local/share/themes" "${HOME}/.local/share/PrismLauncher/themes"

	# GTK and Prismlauncher themes
	unzip -o "${directory}/assets/gtk/catppuccin-mocha-mauve-standard+default.zip" -d "${HOME}/.local/share/themes/" || errorHandling 3
	unzip -o "${directory}/assets/gtk/gtk-4.0.zip" -d "${HOME}/.config/" || errorHandling 3
	unzip -o "${directory}/assets/prismlauncher/Prismlauncher-themes.zip" -d "${HOME}/.local/share/PrismLauncher/themes/" || errorHandling 3

	# Nitrogen config
	echo -e "[xin_-1]\nfile=/home/${USER}/.config/wallpapers/cloudy_crescent.png\nmode=5\nbgcolor=#000000" >"${directory}/config/nitrogen/bg-saved.cfg"
	echo -e "[geometry]\n\n[nitrogen]\nview=list\nrecurse=true\nsort=alpha\nicon_caps=false\ndirs=/home/${USER}/.config/wallpapers;" >"${directory}/config/nitrogen/nitrogen.cfg"

	# Permissions & .config
	chmod +x "${directory}/config/polybar/launch.sh"
	chmod +x "${directory}/config/rofi/scripts/"*
	cp -r "${directory}"/config/* "${HOME}/.config/"

	# SDDM Theme
	sudo unzip -o "${directory}/assets/sddm/catppuccin-mocha.zip" -d "/usr/share/sddm/themes/" || errorHandling 3
	sudo cp -r "${directory}/assets/sddm/sddm.conf" "/etc/"

	# Nemo scripts & config
	gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty
	gsettings set org.nemo.icon-view default-zoom-level 'larger'
	mkdir -p "${HOME}/.local/share/nemo/scripts/"
	cp -r "${directory}/assets/nemo/"* "${HOME}/.local/share/nemo/scripts/"

	# Bashrc
	cp "${directory}/assets/bashrc/bashrc.txt" "${HOME}/.bashrc"
}

enableServices() {
	# Enables all services that are needed and also disabled other display managers.

	clear
	cat <<"EOF"
┌──────────────────────────────────────────────────┐
│                                                  │
│ Enabling Services...                             │
│                                                  │
└──────────────────────────────────────────────────┘

EOF

	# Internet
	sudo systemctl enable NetworkManager
	# NTP, Time synchronisation
	sudo systemctl enable systemd-timesyncd --now
	# Audio Server
	systemctl --user enable pipewire pipewire-pulse wireplumber
	# SSD, NVME blocks cleanup
	sudo systemctl enable fstrim.timer
	# Display Managers
	sudo systemctl disable gdm
	sudo systemctl disable lightdm
	sudo systemctl enable sddm
}

finished() {
	# Rebooting the machine after 5 seconds.

	clear
	cat <<"EOF"
┌──────────────────────────────────────────────────┐
│                                                  │
│ Installation Finished                            │
│                                                  │
└──────────────────────────────────────────────────┘

EOF

	echo -e "Rebooting in..."
	for i in {5..1}; do
		echo -e "$i"
		sleep 1
	done

	echo -e "Rebooting now!"
	sudo reboot now
}

errorHandling() {
	# Prettier error handling (experimental)

	case "$1" in
	"1")
		echo -e "${red}ERROR${reset}: System update failed. Are you connected to internet?"
		;;
	"2")
		echo -e "${red}ERROR${reset}: Could not install packages. Do you have your package manager configured correctly?"
		;;
	"3")
		echo -e "${red}ERROR${reset}: Could not unzip assets."
		;;
	*)
		echo -e "${red}ERROR${reset}: An unexpected issue has occured."
		;;
	esac
	exit 1
}

exitScript() {
	local message="$1"
	echo -e ""
	echo -e "${red}${message}${reset}"
	exit 0
}

### PROGRAM START ###

# Step 1: Set up trap for SIGINT (CTRL+C)
trap 'exitScript "Aborted!"' SIGINT

# Step 2: Get main directory for variable install paths
directory=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

# Step 3
confirmInstallation

# Step 4
chooseProfile

# Step 5
updateSystem

# Step 6
pacmanPackages

# Step 7
aurPackages

# Step 8
chooseInput

# Step 9
chooseExtras

# Step 10
copyFiles

# Step 11
enableServices

# Step 12
finished
