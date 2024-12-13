#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BLUE='\e[34m'
ENDCOLOR='\e[0m'
RESET='\033[0m'

print_header() {
    echo -e "${BLUE}"
    cat <<"EOF"
----------------------------------------------------------------------------------------

     ██╗██╗   ██╗███████╗████████╗██╗   ██╗███████╗    ██╗██████╗ ██╗    ██╗███╗   ███╗
     ██║██║   ██║██╔════╝╚══██╔══╝██║   ██║██╔════╝    ██║╚════██╗██║    ██║████╗ ████║
     ██║██║   ██║███████╗   ██║   ██║   ██║███████╗    ██║ █████╔╝██║ █╗ ██║██╔████╔██║
██   ██║██║   ██║╚════██║   ██║   ██║   ██║╚════██║    ██║ ╚═══██╗██║███╗██║██║╚██╔╝██║
╚█████╔╝╚██████╔╝███████║   ██║   ╚██████╔╝███████║    ██║██████╔╝╚███╔███╔╝██║ ╚═╝ ██║
 ╚════╝  ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝ ╚══════╝    ╚═╝╚═════╝  ╚══╝╚══╝ ╚═╝     ╚═╝
                                                                                       
----------------------------------------------------------------------------------------
          Automated Script for i3wm Setup with Pre-configured Settings

            Repository: https://github.com/Justus0405/i3wm-dotfiles 
----------------------------------------------------------------------------------------
EOF
    echo -e "${ENDCOLOR}"
}

install_package() {
    local package_name="$1"
    if ! command -v "$package_name" &> /dev/null; then
        echo -e "${YELLOW}$package_name is not installed, installing...${RESET}"
        sudo pacman -S --noconfirm "$package_name"
        if [ $? -ne 0 ]; then
            echo -e "${RED}Failed to install $package_name. Please check your package manager.${RESET}"
            exit 1
        fi
    else
        echo -e "${GREEN}$package_name is already installed.${RESET}"
    fi
}

clone_repo() {
    local repo_url="https://github.com/Justus0405/i3wm-dotfiles.git"
    local clone_dir="$HOME/i3wm-dotfiles"
    echo -e "${YELLOW}Cloning the i3wm dotfiles repository into the home directory...${RESET}"
    git clone "$repo_url" "$clone_dir" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Repository cloned successfully to $clone_dir.${RESET}"
    else
        echo -e "${RED}Failed to clone the repository. Please check your internet connection or git configuration.${RESET}"
        exit 1
    fi
}

run_install_script() {
    local install_dir="$HOME/i3wm-dotfiles/src/"
    if [ -d "$install_dir" ]; then
        echo -e "${CYAN}Changing directory to $install_dir and running the install script...${RESET}"
        cd "$install_dir" || exit
        chmod +x install.sh
        ./install.sh
    else
        echo -e "${RED}The installation directory $install_dir does not exist.${RESET}"
        exit 1
    fi
}

main() {
    clear
    print_header
    echo -e "${CYAN}Starting the i3wm Setup Script...${RESET}"

    install_package git

    clone_repo

    run_install_script

    echo -e "${GREEN}i3wm Dotfiles setup completed successfully!${RESET}"
}

main

