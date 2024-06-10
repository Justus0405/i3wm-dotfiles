<div align = center><h1>Justus0405 i3-wm Catppuccin Dotfiles</h1><br><br>
<div align = left>
 
> ~One config per application philosophy <br>
> Why? Because I have OCD

> xf86-input-evdev instead of libinput <br> 
> Why? Because it has way better latency and accuracy

> No Compositor, Compositorless <br>
> Why? Because it has better performance and latency especially on lower end hardware, plus they tend to break multi-monitor setups

## Screenshots

<div align="center"><table><tr><td>Desktop Busy</td><td>Desktop Clear</td><td>Laptop Clear</td>/tr><tr><td>
<img src="https://github.com/Justus0405/i3wm-dotfiles/assets/143542687/d4c5504f-49e9-438c-a139-1564b8d4bb35"/></td><td>
<img src="https://github.com/Justus0405/i3wm-dotfiles/assets/143542687/e5713d05-7c7c-4e3b-904e-1fc28fe1ab9d"/></td><td>
<img src="https://github.com/Justus0405/i3wm-dotfiles/assets/143542687/0261a05d-3c34-4484-8043-532ed8683106"/></td></tr>

## Installation

The installation script is made for Arch, but **may** work on some Arch based distros with **systemd**.

> CAUTION!
> This script is designed to be done after a minimal arch installation, using it on previously installed desktop should work but will change whatever you currently have (gtk/qt theming, shell, sddm, etc) and is at your own risk.

After a minimal Arch install (with grub and systemd), execute -

<div align = left>

```shell
pacman -Syy git
git clone https://github.com/Justus0405/i3wm-dotfiles.git
cd i3wm-dotfiles/src/
chmod +x install.sh
./install.sh
```

<div align = left>

After the installation is finished the script will automaticly reboot into the new enviroment.

## Keybinds

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>RETURN / ENTER</kbd> | launch alacritty (terminal)
| <kbd>Super</kbd> + <kbd>D</kbd> | launch rofi (application launcher)
| <kbd>Super</kbd> + <kbd>E</kbd> | launch nemo (filemanager)
| <kbd>Super</kbd> + <kbd>B</kbd> | launch brave
| <kbd>Super</kbd> + <kbd>M</kbd> | take a screenshot
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
<div align = left>

## Credits

 - neofetch : https://github.com/prasanthrangan/hyprdots
 - alacritty : https://github.com/catppuccin/alacritty
 - rofi : https://github.com/catppuccin/rofi
 - GTK : https://github.com/catppuccin/gtk
 - SDDM : https://github.com/catppuccin/sddm
