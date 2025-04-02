#!/bin/bash

# Get main directory for variable install paths
dirMain=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

# //////////////////////////////////////////////////
#
# Check and Install Gum
#
# //////////////////////////////////////////////////
checkAndInstallGum() {
    if ! command -v gum &> /dev/null; then
        echo "Gum not found. Installing gum..."
        sudo pacman -S --needed --noconfirm gum || {
            echo "Failed to install gum. Continuing with standard UI..."
            return 1
        }
        echo "Gum installed successfully!"
    fi
    return 0
}

# //////////////////////////////////////////////////
#
# Confirmation Function
#
# //////////////////////////////////////////////////
confirmInstallation() {
    clear
    if command -v gum &> /dev/null; then
        gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Catppuccin Dotfiles" "By Justus0405" " " "Installer Version 1.6"
        
        gum confirm "Continue installation?" && {
            echo "Installing..."
            sleep 1
        } || {
            echo "Aborting!"
            exit 0
        }
    else
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
    fi
}

# //////////////////////////////////////////////////
#
# Choose Edition Function
#
# //////////////////////////////////////////////////
chooseProfile() {
    if command -v gum &> /dev/null; then
        clear
        gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Choose your profile"
        
        gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 " 1) Minimal " " " "Packages : Window Manager, Login Manager, File Manager," "           Basic Fonts, Icons, Audio, Input, Screenshots" "Browser  : Chromium" "Media    : none"
        
        gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 " 2) Standard " " " "Packages : Minimal+, All Fonts, Calculator, Disk Utility, Yay" " " "Browser  : Brave" "Media    : Totem, Loupe"
        
        gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 " 3) Full " " " "Packages : Standard+, OBS, GIMP, Shotcut, Steam, Dev-Enviroment," "           Java, Prismlauncher, CurseForge, r2modman, yt-dlp" "Browser  : Brave" "Media    : Totem, Loupe"
        
        choice=$(gum choose "Minimal" "Standard" "Full")
        
        case "$choice" in
        "Minimal")
            edition="0"
            gum style --foreground 212 "Installing Minimal Edition"
            ;;
        "Standard")
            edition="1"
            gum style --foreground 212 "Installing Standard Edition"
            ;;
        "Full")
            edition="2"
            gum style --foreground 212 "Installing Full Edition"
            ;;
        "Exit")
            gum style --foreground 196 "Installation aborted!"
            exit 0
            ;;
        esac
    else
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
            "4" | "exit" | "Exit")
                echo -e "Installation aborted!"
                exit 0
                ;;
            *)
                echo -e "Invalid Answer"
                continue
                ;;
            esac
        done
    fi
}

# //////////////////////////////////////////////////
#
# Update System Function
#
# //////////////////////////////////////////////////
updateSystem() {
    clear
    if command -v gum &> /dev/null; then
        gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Updating System..."
        echo "Running system update..."
        sudo pacman -Syyu --noconfirm || errorHandling 1
    else
        cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Updating System...                               │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF

        sudo pacman -Syyu --noconfirm || errorHandling 1
    fi
}

## //////////////////////////////////////////////////
#
# Install Packages Sub-Function
#
# //////////////////////////////////////////////////
installPackages() {
    local file="$1"
    if command -v gum &> /dev/null; then
        gum style --foreground 212 "Installing packages from $file..."
        sed '/^\s*#/d;/^\s*$/d' "$dirMain/packages/$file" | sudo pacman -S --needed --noconfirm - || errorHandling 2
    else
        sed '/^\s*#/d;/^\s*$/d' "$dirMain/packages/$file" | sudo pacman -S --needed --noconfirm - || errorHandling 2
    fi
}

# //////////////////////////////////////////////////
#
# Install System using Pacman Function
#
# //////////////////////////////////////////////////
pacmanPackages() {
    clear
    if command -v gum &> /dev/null; then
        gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Installing System Packages..."

        # Info message for right vulkan driver
        case "$edition" in
        "2")
            # Full
            gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 " Steam requires the usage of vulkan which needs a specific driver you need to choose. " " The Open-Source variants are all part of the Mesa project " \
            " " \
            " Nvidia -> nvidia-utils            (Proprietary) (Recommended) " \
            " Nvidia -> vulkan-nouveau          (Open-Source) (Slower) " \
            " " \
            " Amd    -> vulkan-radeon           (Open-Source) (Recommended) " \
            " Amd    -> amdvlk                  (Proprietary) (Slower) " \
            " " \
            " Intel  -> vulkan-intel            (Open-Source) (Recommended) " \
            " " \
            " Virtual Machines -> vulkan-virtio (Open-Source) (Recommended) " \
            " " \
            " Software -> vulkan-swrast         (Open-Source) (Very Slow) "
            ;;
        esac
    else
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
    fi

    # Pacman
    case "$edition" in
    "0")
        # Minimal
        installPackages "minimal.txt"
        sed -i 's/brave/chromium/g' "$dirMain/config/i3/config"
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

checkAndInstallAURHelper() {
    if command -v paru &> /dev/null; then
        echo "Paru is already installed, using it as AUR helper"
        aur_helper="paru"
        return 0
    fi
    
    if command -v yay &> /dev/null; then
        echo "Yay is already installed, using it as AUR helper"
        aur_helper="yay"
        return 0
    fi
    
    echo "No AUR helper found. Installing yay..."
    cd "$dirMain" || exit 1
    
    if command -v gum &> /dev/null; then
        echo "Cloning yay repository..."
        git clone https://aur.archlinux.org/yay.git
        cd yay || exit 1
        echo "Building yay..."
        makepkg -si --noconfirm
    else
        git clone https://aur.archlinux.org/yay.git
        cd yay || exit 1
        makepkg -si --noconfirm
    fi
    
    cd "$dirMain" || exit 1
    aur_helper="yay"
}

aurPackages() {
    clear
    if command -v gum &> /dev/null; then
        gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Installing AUR Packages..."
    else
        cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Installing AUR Packages...                       │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF
    fi

    checkAndInstallAURHelper

    case "$edition" in
    "1")
        if command -v gum &> /dev/null; then
            echo "Installing brave-bin and catnap-git..."
            $aur_helper -S --noconfirm brave-bin catnap-git
        else
            $aur_helper -S --noconfirm brave-bin catnap-git
        fi
        ;;
    "2")
        if command -v gum &> /dev/null; then
            echo "Installing AUR packages..."
            $aur_helper -S --noconfirm brave-bin catnap-git vscodium-bin r2modman-appimage curseforge
        else
            $aur_helper -S --noconfirm brave-bin catnap-git vscodium-bin r2modman-appimage curseforge
        fi
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
    if command -v gum &> /dev/null; then
        gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Choose input settings"
        
        layout=$(gum input --placeholder "Please choose your keyboard layout ('us' or 'de' for Desktop, 'de-latin1' for Laptops)")
        while ! sudo localectl set-keymap "$layout"; do
            gum style --foreground 196 "${layout} is not a valid keyboard layout"
            layout=$(gum input --placeholder "Please choose your keyboard layout ('us' or 'de' for Desktop, 'de-latin1' for Laptops)")
        done
        
        gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 " Please choose your preferred input driver " \
        " 1: libinput (Default) | Best hardware support, variable sensitivity, High Latency " \
        " 2: xf86-input-evdev   | Lowest Latency, limited support, no sensitivity setting "
        
        choice=$(gum choose "libinput" "xf86-input-evdev")
        
        case "$choice" in
        "libinput")
            gum style --foreground 212 "You chose libinput"
            ;;
        "xf86-input-evdev")
            # xf86-input-evdev
            gum style --foreground 212 "You chose xf86-input-evdev"
            mkdir -p "$HOME/.config"
            sudo mv "/usr/share/X11/xorg.conf.d/40-libinput.conf" "$HOME/.config/"
            sudo cp -r "$dirMain/assets/50-mouse-acceleration.conf" "/etc/X11/xorg.conf.d/"
            ;;
        esac
    else
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
    fi
}

# //////////////////////////////////////////////////
#
# Choose Extras Function
#
# //////////////////////////////////////////////////
chooseExtras() {
    clear
    if command -v gum &> /dev/null; then
        gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Choose extra settings"
        
        if gum confirm "Add a Wifi Menu to the top bar? (Recommended for Laptops)"; then
            gum style --foreground 212 "Adding Wifi Menu..."
            sudo pacman -S --needed --noconfirm network-manager-applet
        else
            gum style --foreground 212 "Skipping..."
        fi
        
        if gum confirm "Add Bluetooth support?"; then
            gum style --foreground 212 "Adding Bluetooth Menu..."
            sudo pacman -S --needed --noconfirm bluez bluez-utils blueman
            sudo systemctl enable bluetooth.service
        else
            gum style --foreground 212 "Skipping..."
        fi
    else
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
    fi
}

# //////////////////////////////////////////////////
#
# Copy Config Files and Themes Function
#
# //////////////////////////////////////////////////
copyFiles() {
    clear
    if command -v gum &> /dev/null; then
        gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Copying Files..."
    else
        cat <<"EOF"
╭──────────────────────────────────────────────────╮
│                                                  │
│ Copying Files...                                 │
│                                                  │
╰──────────────────────────────────────────────────╯

EOF
    fi

    # Create directories
    if command -v gum &> /dev/null; then
        echo "Creating directories..."
        mkdir -p "$HOME/.config" "$HOME/.local/share/themes" "$HOME/.local/share/PrismLauncher/themes"
    else
        mkdir -p "$HOME/.config" "$HOME/.local/share/themes" "$HOME/.local/share/PrismLauncher/themes"
    fi

    # GTK and Prismlauncher themes
    if command -v gum &> /dev/null; then
        echo "Extracting themes..."
        unzip -o "$dirMain/assets/catppuccin-mocha-mauve-standard+default.zip" -d "$HOME/.local/share/themes/" || errorHandling 3
        echo "Extracting GTK themes..."
        unzip -o "$dirMain/assets/gtk-4.0.zip" -d "$HOME/.config/" || errorHandling 3
        echo "Extracting PrismLauncher themes..."
        unzip -o "$dirMain/assets/Prismlauncher-themes.zip" -d "$HOME/.local/share/PrismLauncher/themes/" || errorHandling 3
    else
        unzip -o "$dirMain/assets/catppuccin-mocha-mauve-standard+default.zip" -d "$HOME/.local/share/themes/" || errorHandling 3
        unzip -o "$dirMain/assets/gtk-4.0.zip" -d "$HOME/.config/" || errorHandling 3
        unzip -o "$dirMain/assets/Prismlauncher-themes.zip" -d "$HOME/.local/share/PrismLauncher/themes/" || errorHandling 3
    fi

    # Nitrogen config
    echo -e "[xin_-1]\nfile=/home/$USER/.config/wallpapers/rocket_launch.png\nmode=5\nbgcolor=#000000" >"$dirMain/config/nitrogen/bg-saved.cfg"
    echo -e "[geometry]\n\n[nitrogen]\nview=list\nrecurse=true\nsort=alpha\nicon_caps=false\ndirs=/home/$USER/.config/wallpapers;" >"$dirMain/config/nitrogen/nitrogen.cfg"

    # Permissions & .config
    chmod +x "$dirMain/config/polybar/launch.sh"
    chmod +x "$dirMain/config/rofi/powermenu"
    
    if command -v gum &> /dev/null; then
        echo "Copying config files..."
        cp -r "$dirMain"/config/* "$HOME/.config/"
    else
        cp -r "$dirMain"/config/* "$HOME/.config/"
    fi

    # SDDM Theme
    if command -v gum &> /dev/null; then
        echo "Installing SDDM theme..."
        sudo unzip -o "$dirMain/assets/catppuccin-mocha.zip" -d "/usr/share/sddm/themes/" || errorHandling 3
        echo "Configuring SDDM..."
        sudo cp -r "$dirMain/assets/sddm.conf" "/etc/"
    else
        sudo unzip -o "$dirMain/assets/catppuccin-mocha.zip" -d "/usr/share/sddm/themes/" || errorHandling 3
        sudo cp -r "$dirMain/assets/sddm.conf" "/etc/"
    fi

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
    if command -v gum &> /dev/null; then
        echo "Configuring Nemo defaults..."
        gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty
    else
        gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty
    fi
}

# //////////////////////////////////////////////////
#
# Enable Services Function
#
# //////////////////////////////////////////////////
enableServices() {
    clear
    if command -v gum &> /dev/null; then
        gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Enabling Services..."
        
        echo "Enabling user services..."
        systemctl --user enable pipewire pipewire-pulse wireplumber

        echo "Enabling system time sync..."
        sudo systemctl enable systemd-timesyncd --now

        echo "Enabling NetworkManager..."
        sudo systemctl enable NetworkManager

        echo "Disabling GDM..."
        sudo systemctl disable gdm

        echo "Disabling LightDM..."
        sudo systemctl disable lightdm

        echo "Enabling SDDM..."
        sudo systemctl enable sddm
    else
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
    fi
}

# //////////////////////////////////////////////////
#
# Reboot Prompt Function
#
# //////////////////////////////////////////////////
finished() {
    clear
    if command -v gum &> /dev/null; then
        gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Installation Finished"
        
        gum style --foreground 212 "Rebooting in..."
        for i in {5..1}; do
            gum style --foreground 212 "$i"
            sleep 1
        done
        
        gum style --foreground 212 "Rebooting now!"
        sudo reboot now
    else
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
    fi
}

# //////////////////////////////////////////////////
#
# Error Handling Function (Experimental)
#
# //////////////////////////////////////////////////
errorHandling() {
    if command -v gum &> /dev/null; then
        case "$1" in
        "1")
            gum style --foreground 196 "Error: System update failed. Exiting."
            ;;
        "2")
            gum style --foreground 196 "Error: couldn't install packages. Do you have your package manager configured correctly?"
            ;;
        "3")
            gum style --foreground 196 "Error: couldn't unzip assets. Do you have your package manager configured correctly?"
            ;;
        *)
            gum style --foreground 196 "Error: Unexpected issue."
            ;;
        esac
    else
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
    fi
    exit 1
}

# //////////////////////////////////////////////////
#
# PROGRAM START
#
# //////////////////////////////////////////////////

# Step 1: Set up trap for SIGINT (CTRL+C)
trap 'echo -e "Exited"; exit 0' SIGINT

# Step 0: Check and install gum
checkAndInstallGum

# Step 2
confirmInstallation

# Step 3
chooseProfile

# Step 4
updateSystem

# Step 5
pacmanPackages

# Step 6
aurPackages

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
