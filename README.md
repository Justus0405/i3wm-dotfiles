# Justus0405 i3-wm Catppuccin Dotfiles

<img src="https://github.com/harilvfs/assets/blob/main/themes/themes.png" width="30" /> <img src="https://img.shields.io/badge/Theme-Catppuccin-blue?style=for-the-badge&color=7dc4e4&logoColor=D9E0EE&labelColor=1c1c29"> 

<img src="https://img.shields.io/github/issues/Justus0405/i3wm-dotfiles?style=for-the-badge&color=dbb6ed&logoColor=85e185&labelColor=1c1c29" /> <img src="https://img.shields.io/github/issues-pr/Justus0405/i3wm-dotfiles?style=for-the-badge&color=ef9f9c&logoColor=85e185&labelColor=1c1c29" /> <img src="https://img.shields.io/github/last-commit/Justus0405/i3wm-dotfiles?style=for-the-badge&logo=github&color=7dc4e4&logoColor=D9E0EE&labelColor=1c1c29"/> <img src="https://img.shields.io/github/stars/Justus0405/i3wm-dotfiles?style=for-the-badge&logo=apachespark&color=eed49f&logoColor=D9E0EE&labelColor=1c1c29"/> <img src="https://img.shields.io/github/forks/Justus0405/i3wm-dotfiles?style=for-the-badge&color=9dc3ea&logoColor=D9E0EE&labelColor=1c1c29" /> 
## Installation

> [!IMPORTANT]  
> The installation script is made for Arch,
> but **may** work on some Arch based distros with **systemd**.


> [!CAUTION]  
> This script is designed to be done after a minimal arch installation,
> using it on previously installed desktop should work but will change whatever you currently have (gtk/qt theming, shell, sddm, etc) and is at your own risk.
<br>

***After a minimal Arch install (with grub and systemd), execute -***

```shell
bash <(curl -L https://raw.githubusercontent.com/Justus0405/i3wm-dotfiles/refs/heads/main/setup.sh)
```
> [!NOTE]
> Ensure curl is installed first using:
> `sudo pacman -S curl`


**After the installation is finished the script will automaticly reboot into the new enviroment.**

<br>

## Screenshots

<div align="center"><table><tr><td>Desktop Clear</td><td>Desktop Busy</td></tr><tr><td>
<img src="https://github.com/user-attachments/assets/aab7c2f2-4b72-44ab-9e21-b6cded4f98c2"/></td><td>
<img src="https://github.com/user-attachments/assets/8287e5f1-6152-4764-8f89-7e78c93212e5"/></td></tr>
</table></div>

<br>

## FAQ

### How do I change, add, or delete wallpapers?

- **To change your wallpaper:** Press `SUPER + D`, type `Nitrogen`, and press Enter to open it. Select your desired wallpaper and click "Apply" at the bottom-right corner.
- **To add or delete wallpapers:** Copy your wallpaper files to `~/.config/wallpapers/` to add them, or delete files from this directory to remove them.

<br>

## Keybinds

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>RETURN / ENTER</kbd> | launch alacritty (terminal)
| <kbd>Super</kbd> + <kbd>E</kbd> | launch nemo (filemanager)
| <kbd>Super</kbd> + <kbd>B</kbd> | launch brave (browser)
| <kbd>Super</kbd> + <kbd>N</kbd> | screenshot selected area (flameshot)
| <kbd>Super</kbd> + <kbd>M</kbd> | screenshot entire screen (flameshot)
| <kbd>Super</kbd> + <kbd>Q</kbd> | quit active/focused window

<br>

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>D</kbd> | Rofi (application launcher)
| <kbd>Super</kbd> + <kbd>O</kbd> | Rofi (ssh selector)
| <kbd>Super</kbd> + <kbd>P</kbd> | Rofi (calculator)
| <kbd>ALT</kbd> + <kbd>TAB</kbd> | Rofi (window switcher)

<br>

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>NUMBER</kbd> | switch to workspace
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>NUMBER</kbd> | move focused container to workspace
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>C</kbd> | reload the configuration file
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>R</kbd> | restart i3
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd> | quit i3 session

<br>

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>J</kbd> | focus left
| <kbd>Super</kbd> + <kbd>K</kbd> | focus down
| <kbd>Super</kbd> + <kbd>L</kbd> | focus up
| <kbd>Super</kbd> + <kbd>O</kbd> | focus right

<br>

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>J</kbd> | move left
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>K</kbd> | move down
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>L</kbd> | move up
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>O</kbd> | move right

<br>

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>H</kbd> | split in horizontal orientation
| <kbd>Super</kbd> + <kbd>V</kbd> | split in vertical orientation
| <kbd>Super</kbd> + <kbd>F</kbd> | enter fullscreen mode for the focused container

<br>

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>SPACE</kbd> | toggle tiling / floating
| <kbd>Super</kbd> + <kbd>SPACE</kbd> | change focus between tiling / floating windows
| <kbd>Super</kbd> + <kbd>A</kbd> | focus the parent container
| <kbd>Super</kbd> + <kbd>D</kbd> | focus the child container

<br>

## 🌟 Credits

### 🎨 Catppuccin Team  
- 🌸 [Alacritty](https://github.com/catppuccin/alacritty)  
- ☕ [Rofi](https://github.com/catppuccin/rofi)  
- 🖌️ [GTK](https://github.com/catppuccin/gtk)  
- 🌙 [SDDM](https://github.com/catppuccin/sddm)  

### 🌟 Others  
- 🛌 [iinsertNameHere](https://github.com/iinsertNameHere/catnap)  
- 🌀 [prasanthrangan](https://github.com/prasanthrangan/hyprdots)  
- ⚡ [jluttine](https://github.com/jluttine/rofi-power-menu)  

