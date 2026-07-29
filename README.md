<img width="2000" height="500" alt="Banner" src="https://github.com/user-attachments/assets/367e3101-1ad1-438b-875a-04a9136d67a0" /><br>

<p align="center">
    <!-- Discord Badge -->
    <a href="https://discord.justus0405.com/"><img src="https://img.shields.io/discord/1370519315400495234?logo=Discord&logoColor=89b4fa&colorA=1e1e2e&colorB=a6e3a1&style=for-the-badge"></a>
    <!-- Forks Badge -->
    <a href="https://github.com/Justus0405/i3wm-dotfiles/forks"><img src="https://img.shields.io/github/forks/Justus0405/i3wm-dotfiles?colorA=1e1e2e&colorB=ea999c&style=for-the-badge"></a>
    <!-- Stars Badge -->
    <a href="https://github.com/Justus0405/i3wm-dotfiles/stargazers"><img src="https://img.shields.io/github/stars/Justus0405/i3wm-dotfiles?colorA=1e1e2e&colorB=b7bdf8&style=for-the-badge"></a>
    <!-- Last Commit Badge -->
    <a href="https://github.com/Justus0405/i3wm-dotfiles/commits/main/"><img src="https://img.shields.io/github/last-commit/Justus0405/i3wm-dotfiles?logo=github&logoColor=cdd6f4&colorA=1e1e2e&colorB=cdd6f4&style=for-the-badge"></a>
</p>

<p align="center">
My personal dotfiles. Built with simplicity, no animations, no blur, no rounded corners, no compositor.
</p>

## Installation

> [!IMPORTANT]
> Made for Arch based distros with systemd, on a fresh minimal install.
> Running it on an existing desktop overwrites your theming, shell, and display manager config.

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

## Applications

| Role           | Package                    |
| -------------- | -------------------------- |
| Window Manager | `i3-wm`                    |
| Login Manager  | `ly`                       |
| App Launcher   | `rofi`                     |
| Status Bar     | `polybar`                  |
| Wallpaper      | `feh`                      |
| File Manager   | `nemo`                     |
| Terminal       | `alacritty`                |
| Browser        | `chromium` + `brave`       |
| Media Player   | `mpv`                      |
| Screenshot     | `flameshot`                |
| Audio          | `pipewire` + `wireplumber` |
| Text Editor    | `nano`                     |
| Icon Theme     | `papirus-icon-theme`       |
| Font           | `ttf-jetbrains-mono-nerd`  |

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

| Keys                                                    | Action                                          |
| :------------------------------------------------------ | :---------------------------------------------- |
| <kbd>Super</kbd> + <kbd>NUMBER</kbd>                    | switch to workspace                             |
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>NUMBER</kbd> | move focused container to workspace             |
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>C</kbd>      | reload the configuration file                   |
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>R</kbd>      | restart i3                                      |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd>      | quit i3 session                                 |
| <kbd>Super</kbd> + <kbd>F</kbd>                         | enter fullscreen mode for the focused container |
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>SPACE</kbd>  | toggle tiling / floating                        |

<br>

| Keys                                               | Action     |
| :------------------------------------------------- | :--------- |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>←</kbd> | move left  |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>↓</kbd> | move down  |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>↑</kbd> | move up    |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>→</kbd> | move right |

<br>

## Credits

- [Catppuccin Team](https://github.com/catppuccin)
- [adi1090x](https://github.com/adi1090x/rofi)
- [Samillion](https://github.com/Samillion/ModernZ)

#

<p align="center">
	Copyright &copy; 2024-present <a href="https://github.com/Justus0405" target="_blank">Justus0405</a>
</p>

<p align="center">
	<a href="https://github.com/Justus0405/i3wm-dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/github/license/Justus0405/i3wm-dotfiles?logo=Github&colorA=1e1e2e&colorB=cba6f7&style=for-the-badge"></a>
</p>
