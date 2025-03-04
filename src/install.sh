#!/bin/bash

# Get main directory for variable install paths
export dirMain=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

## Main Functions

# Starting Function
confirmInstallation() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Catppuccin Dotfiles                              │
│ By Justus0405                                    │
│                                                  │
│ Installer Version 1.5                            │
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

# Function to determine the wanted edition
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
		echo -e "│ Packages : Minimal+, All Fonts, Calculator, Disk Utility, Yay   │"
		echo -e "│                                                                 │"
		echo -e "│ Browser  : Brave                                                │"
		echo -e "│ Media    : Totem, Loupe                                         │"
		echo -e "╰─────────────────────────────────────────────────────────────────╯"
		echo -e ""

		echo -e "╭─────────────────────────────────────────────────────────────────╮"
		echo -e "│ 3) Full                                                         │"
		echo -e "├─────────────────────────────────────────────────────────────────┤"
		echo -e "│ Packages : Standard+, OBS, GIMP, Shotcut, Steam, Dev-Enviroment,│"
		echo -e "│            Java, Prismlauncher, CurseForge, r2modman, yt-dlp    │"
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

# Function for updating the host system
updateSystem() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Updating System...                               │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

	sudo pacman -Syyu || errorHandling 1

}

# Function for installing needed packages
installPackages() {
	clear
	cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Installing Packages...                           │
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

	# Pacman Packages
	minimal="alacritty bash-completion chromium flameshot gnome-keyring gnu-free-fonts gst-plugin-pipewire i3-wm lib32-pipewire nemo nemo-audio-tab nemo-fileroller nemo-image-converter nemo-share nitrogen papirus-icon-theme pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse polkit-gnome polybar qt5-graphicaleffects qt5-quickcontrols2 qt5-svg qt6-svg qt6-declarative rofi rofi-calc rtkit sddm ttf-jetbrains-mono ttf-jetbrains-mono-nerd unzip wget wireplumber xf86-input-evdev xf86-input-synaptics"

	standard="fuse gnome-calculator gnome-disk-utility gnome-text-editor gst-libav gst-plugins-ugly gvfs gvfs-smb htop loupe lxappearance-gtk3 nano noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra ntfs-3g pacman-contrib totem"

	full="code dosfstools ffmpeg gimp gnome-calendar gnome-color-manager intellij-idea-community-edition jdk17-openjdk jdk21-openjdk jdk8-openjdk nvtop obs-studio p7zip pavucontrol prismlauncher pycharm-community-edition qt6-multimedia-ffmpeg resources steam shotcut unrar yt-dlp"

	# Pacman
	case "$edition" in
	"0")
		# Minimal
		sudo pacman -S --needed $minimal || errorHandling 2
		sed -i 's/brave/chromium/g' "$dirMain/config/i3/config"
		;;
	"1")
		# Standard
		sudo pacman -S --needed $minimal $standard || errorHandling 2
		;;
	"2")
		# Full
		sudo pacman -S --needed $minimal $standard $full || errorHandling 2
		;;
	esac

	# Important for Pipewire
	sudo usermod -a -G rtkit $USER

	# Yay Packages
	yayStandard="brave-bin catnap-git"

	yayFull="r2modman-appimage curseforge"

	# Yay
	case "$edition" in
	"1")
		cd "$dirMain" || exit 1
		git clone https://aur.archlinux.org/yay.git
		cd yay || exit 1
		makepkg -si --noconfirm
		cd ..

		yay -S --noconfirm $yayStandard
		;;
	"2")
		cd "$dirMain" || exit 1
		git clone https://aur.archlinux.org/yay.git
		cd yay || exit 1
		makepkg -si --noconfirm
		cd ..

		yay -S --noconfirm $yayStandard $yayFull
		;;
	esac
}

# Function for choosing input settings
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
			# xf86-input-evdev
			echo -e "You chose xf86-input-evdev"
			mkdir -p "$HOME/.config"
			sudo mv "/usr/share/X11/xorg.conf.d/40-libinput.conf" "$HOME/.config/"
			sudo cp -r "$dirMain/assets/50-mouse-acceleration.conf" "/etc/X11/xorg.conf.d/"
			break
			;;
		*)
			echo -e "Invalid Answer"
			continue
			;;
		esac
	done
}

# Function for choosing extras
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
}

# Function for copying config files
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
	unzip "$dirMain/assets/catppuccin-mocha-mauve-standard+default.zip" -d "$HOME/.local/share/themes/" || errorHandling 3
	unzip "$dirMain/assets/gtk-4.0.zip" -d "$HOME/.config/" || errorHandling 3
	unzip "$dirMain/assets/Prismlauncher-themes.zip" -d "$HOME/.local/share/PrismLauncher/themes/" || errorHandling 3

	# Nitrogen config
	echo -e "[xin_-1]\nfile=/home/$USER/.config/wallpapers/rocket_launch.png\nmode=5\nbgcolor=#000000" >"$dirMain/config/nitrogen/bg-saved.cfg"
	echo -e "[geometry]\n\n[nitrogen]\nview=list\nrecurse=true\nsort=alpha\nicon_caps=false\ndirs=/home/$USER/.config/wallpapers;" >"$dirMain/config/nitrogen/nitrogen.cfg"

	# Permissions & .config
	chmod +x "$dirMain/config/polybar/launch.sh"
	chmod +x "$dirMain/config/rofi/powermenu"
	cp -r "$dirMain"/config/* "$HOME/.config/"

	# SDDM Theme
	sudo unzip "$dirMain/assets/catppuccin-mocha.zip" -d "/usr/share/sddm/themes/" || errorHandling 3
	sudo cp -r "$dirMain/assets/sddm.conf" "/etc/"

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

	# Nemo default "open in terminal" application fix
	gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty
}

# Function for enabling services
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
	sudo systemctl enable NetworkManager
	sudo systemctl disable gdm
	sudo systemctl disable lightdm
	sudo systemctl enable sddm
}

# Function for rebooting
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

# Experimental way for handling errors using codes
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

# PROGRAM START

# Step 1: Set up trap for SIGINT (CTRL+C)
trap 'echo -e "Exited"; exit 0' SIGINT

# Step 2
confirmInstallation
# Step 3
chooseProfile
# Step 4
updateSystem
# Step 5
installPackages
# Step 6
chooseInput
# Step 7
chooseExtras
# Step 8
copyFiles
# Step 9
enableServices
# Step 10
finished
