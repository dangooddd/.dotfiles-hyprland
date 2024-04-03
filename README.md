# <span style="color:#938aa9">dangooddd linux dotfiles</span>
Just another Wayland rice, made by me :)

## <span style="color:#b16286">Look</span>

<img align="center" src="./screenshots/look.png">

## <span style="color:#b16286">Configurations</span> 
* **Window Manager:** [Hyprland](https://github.com/hyprwm/Hyprland)
* **Terminal:** [foot](https://codeberg.org/dnkl/foot)
* **App Launcher:** [fuzzel](https://codeberg.org/dnkl/fuzzel)
* **Notification manager:** [mako](https://github.com/emersion/mako)
* **Screen locker:** [Hyprlock](https://github.com/hyprwm/hyprlock)
* **Idle:** [Hypridle](https://github.com/hyprwm/hypridle)
* **Wallpaper manager:** [Hyprpaper](https://github.com/hyprwm/hyprpaper)
* **Bar:** [waybar](https://github.com/Alexays/Waybar)
* **Logout widget:** [wlogout](https://github.com/ArtsyMacaw/wlogout)
* **Qt theming:** [Kvantum](https://github.com/tsujan/Kvantum/tree/master/Kvantum)
* **Code Editor:** [NeoVim](https://github.com/neovim/neovim) with [NvChad](https://github.com/NvChad/NvChad) config
* **Font:** [Inter](https://github.com/rsms/inter) as UI font and [Cascadia Code Nerd](https://github.com/microsoft/cascadia-code) as monospace font

## <span style="color:#b16286">Installation</span>

### <span style="color:#e6c384">Download</span>
```bash
git clone https://github.com/dangooddd/.dotfiles.git
```

### <span style="color:#e6c384">Manual</span>
For all config dirs you want to install:
```bash
ln -s /path/to/folder/.config/config_dir $HOME/.config 
```
If you want to use gtk theme of my choice:
```bash
ln -s /path/to/folder/.themes $HOME/.themes
```

### <span style="color:#c34043">WARNING!</span>
Method below may be dangerous! It can delete some files from your .config and .themes dirs, so read code and make decision!

### <span style="color:#e6c384">Via script</span>
```bash
cd .dotfiles
./install.sh
```

If you want to delete your old config files that was moved to .bak files:
```bash
./clean.sh
```
