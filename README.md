![Justus0405 i3-wm Catppuccin Dotfiles](https://github.com/user-attachments/assets/2eaa5c58-7aba-40a1-84ba-0abd88d56092)

<p align="center">
    <!-- Discord Badge -->
    <a href="https://discord.justus0405.com/"><img src="https://img.shields.io/discord/1370519315400495234?logo=Discord&colorA=1e1e2e&colorB=a6e3a1&style=for-the-badge"></a>
    <!-- Forks Badge -->
    <a href="https://github.com/Justus0405/i3wm-dotfiles/forks"><img src="https://img.shields.io/github/forks/Justus0405/i3wm-dotfiles?colorA=1e1e2e&colorB=ea999c&style=for-the-badge"></a>
    <!-- Stars Badge -->
    <a href="https://github.com/Justus0405/i3wm-dotfiles/stargazers"><img src="https://img.shields.io/github/stars/Justus0405/i3wm-dotfiles?colorA=1e1e2e&colorB=b7bdf8&style=for-the-badge"></a>
    <!-- Last Commit Badge -->
    <a href="https://github.com/Justus0405/i3wm-dotfiles/commits/main/"><img src="https://img.shields.io/github/last-commit/Justus0405/i3wm-dotfiles?logo=github&colorA=1e1e2e&colorB=cdd6f4&style=for-the-badge"></a>
</p>

## Installation

> [!IMPORTANT]
> The installation script is made for Arch,
> but **may** work on some Arch based distros with **systemd**.

> [!CAUTION]
> This script is designed to be done after a minimal arch installation,
> using it on previously installed desktop should work but will change whatever you currently have (gtk/qt theming, shell, sddm, etc) and is at your own risk.

1. Clone the repository:

```shell
git clone --depth 1 https://github.com/Justus0405/i3wm-dotfiles.git
```

2. Navigate to the directory:

```shell
cd i3wm-dotfiles/src/
```

3. Make the installation script executable:

```shell
chmod +x install.sh
```

4. Run the installation script:

```shell
./install.sh
```

5. After the installation is finished the script will automaticly reboot into the new enviroment.

<br>

## Screenshots

<div align="center"><table>
<td><img src="https://github.com/user-attachments/assets/1a51ca4e-7b2b-46be-bfe4-0844dc2eea03"/></td>
<td><img src="https://github.com/user-attachments/assets/71eb38d4-0691-4346-b6e3-3df6aa432c96"/></td>
</table></div>

<br>

## FAQ

### How do I change, add, or delete wallpapers?

- **To add or delete wallpapers:** Copy your wallpaper files to `~/.config/wallpapers/` to add them, or delete files from this directory to remove them.
- **To change your wallpaper:** Press `SUPER + W`, select via arrow keys and press Enter to apply it.

<br>

## Keybinds

| Keys                                         | Action                               |
| :------------------------------------------- | :----------------------------------- |
| <kbd>Super</kbd> + <kbd>RETURN / ENTER</kbd> | launch alacritty (terminal)          |
| <kbd>Super</kbd> + <kbd>E</kbd>              | launch nemo (filemanager)            |
| <kbd>Super</kbd> + <kbd>B</kbd>              | launch brave (browser)               |
| <kbd>Super</kbd> + <kbd>N</kbd>              | screenshot selected area (flameshot) |
| <kbd>Super</kbd> + <kbd>M</kbd>              | screenshot entire screen (flameshot) |
| <kbd>Super</kbd> + <kbd>Q</kbd>              | quit active/focused window           |

<br>

| Keys                            | Action                      |
| :------------------------------ | :-------------------------- |
| <kbd>Super</kbd> + <kbd>D</kbd> | Rofi (application launcher) |
| <kbd>Super</kbd> + <kbd>O</kbd> | Rofi (ssh selector)         |
| <kbd>Super</kbd> + <kbd>P</kbd> | Rofi (calculator)           |
| <kbd>Super</kbd> + <kbd>W</kbd> | Rofi (wallpaper picker)     |
| <kbd>ALT</kbd> + <kbd>TAB</kbd> | Rofi (window switcher)      |

<br>

| Keys                                                    | Action                              |
| :------------------------------------------------------ | :---------------------------------- |
| <kbd>Super</kbd> + <kbd>NUMBER</kbd>                    | switch to workspace                 |
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>NUMBER</kbd> | move focused container to workspace |
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>C</kbd>      | reload the configuration file       |
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>R</kbd>      | restart i3                          |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd>      | quit i3 session                     |

<br>

| Keys                            | Action      |
| :------------------------------ | :---------- |
| <kbd>Super</kbd> + <kbd>H</kbd> | focus left  |
| <kbd>Super</kbd> + <kbd>J</kbd> | focus down  |
| <kbd>Super</kbd> + <kbd>K</kbd> | focus up    |
| <kbd>Super</kbd> + <kbd>L</kbd> | focus right |

<br>

| Keys                                               | Action     |
| :------------------------------------------------- | :--------- |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>H</kbd> | move left  |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>J</kbd> | move down  |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>K</kbd> | move up    |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>L</kbd> | move right |

<br>

| Keys                                                   | Action                                          |
| :----------------------------------------------------- | :---------------------------------------------- |
| <kbd>Super</kbd> + <kbd>F</kbd>                        | enter fullscreen mode for the focused container |
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>SPACE</kbd> | toggle tiling / floating                        |
| <kbd>Super</kbd> + <kbd>SPACE</kbd>                    | change focus between tiling / floating windows  |
| <kbd>Super</kbd> + <kbd>A</kbd>                        | focus the parent container                      |
| <kbd>Super</kbd> + <kbd>D</kbd>                        | focus the child container                       |

<br>

## Credits

##### Catppuccin Team

- [Alacritty](https://github.com/catppuccin/alacritty)
- [Rofi](https://github.com/catppuccin/rofi)
- [GTK](https://github.com/catppuccin/gtk)
- [SDDM](https://github.com/catppuccin/sddm)

##### Others

- [iinsertNameHere](https://github.com/iinsertNameHere/catnap)
- [prasanthrangan](https://github.com/prasanthrangan/hyprdots)
- [jluttine](https://github.com/jluttine/rofi-power-menu)

#

<p align="center">
	Copyright &copy; 2024-present <a href="https://github.com/Justus0405" target="_blank">Justus0405</a>
</p>

<p align="center">
	<a href="https://github.com/Justus0405/i3wm-dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/github/license/Justus0405/i3wm-dotfiles?logo=Github&colorA=1e1e2e&colorB=cba6f7&style=for-the-badge"></a>
</p>
