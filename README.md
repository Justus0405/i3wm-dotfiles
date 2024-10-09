# Justus0405 i3-wm Catppuccin Dotfiles

## Installation

The installation script is made for Arch, but **may** work on some Arch based distros with **systemd**.

> This script is designed to be done after a minimal arch installation, using it on previously installed desktop should work but will change whatever you currently have (gtk/qt theming, shell, sddm, etc) and is at your own risk.

After a minimal Arch install (with grub and systemd), execute -

```shell
pacman -Syy git
git clone https://github.com/Justus0405/i3wm-dotfiles.git
cd i3wm-dotfiles/src/
chmod +x install.sh
./install.sh
```

After the installation is finished the script will automaticly reboot into the new enviroment.

<br>
 
## Screenshots

<div align="center"><table><tr><td>Desktop Clear</td><td>Desktop Busy</td></tr><tr><td>
<img src="https://github.com/user-attachments/assets/aab7c2f2-4b72-44ab-9e21-b6cded4f98c2"/></td><td>
<img src="https://github.com/user-attachments/assets/8287e5f1-6152-4764-8f89-7e78c93212e5"/></td></tr>
</table></div>

<br>
 
## Keybinds

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>RETURN / ENTER</kbd> | launch alacritty (terminal)
| <kbd>Super</kbd> + <kbd>D</kbd> | launch rofi (application launcher)
| <kbd>Super</kbd> + <kbd>E</kbd> | launch nemo (filemanager)
| <kbd>Super</kbd> + <kbd>B</kbd> | launch brave (browser)
| <kbd>Super</kbd> + <kbd>N</kbd> | screenshot selected area (flameshot)
| <kbd>Super</kbd> + <kbd>M</kbd> | screenshot entire screen (flameshot)
| <kbd>Super</kbd> + <kbd>Q</kbd> | quit active/focused window
| <kbd>ALT</kbd> + <kbd>TAB</kbd> | switch windows

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

## Credits

- Alacritty : https://github.com/catppuccin/alacritty
- Catnap    : https://github.com/iinsertNameHere/catnap
- Rofi      : https://github.com/catppuccin/rofi
- GTK       : https://github.com/catppuccin/gtk
- SDDM      : https://github.com/catppuccin/sddm
- Neofetch  : https://github.com/prasanthrangan/hyprdots
