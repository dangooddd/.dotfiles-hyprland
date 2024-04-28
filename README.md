# dangooddd linux dotfiles
Minimal setup for work by dangooddd

<img align="center" src="./.samples/look.png">

## Configurations 
* **Window Manager:** [Hyprland](https://github.com/hyprwm/Hyprland)
* **Terminal:** [foot](https://codeberg.org/dnkl/foot)
* **App Launcher:** [fuzzel](https://codeberg.org/dnkl/fuzzel)
* **Notification manager:** [dunst](https://github.com/dunst-project/dunst)
* **Screen locker:** [hyprlock](https://github.com/hyprwm/hyprlock)
* **Idle:** [hypridle](https://github.com/hyprwm/hypridle)
* **Wallpaper manager:** [hyprpaper](https://github.com/hyprwm/hyprpaper)
* **Bar:** [ags](https://github.com/Aylur/ags)
* **Code Editor:** [Helix](https://github.com/helix-editor/helix)
* **Font:** [Inter](https://github.com/rsms/inter) as UI font and [Cascadia Code](https://github.com/microsoft/cascadia-code) as monospace font

## Packages
### Fedora
Enable some copr repos:
```bash 
sudo dnf copr enable atim/starship
sudo dnf copr enable che/nerd-fonts
sudo dnf copr enable solopasha/hyprland
sudo dnf copr enable varlad/zellij
```
Then install packages:
```bash
sudo dnf install python python-pip cascadia-code-fonts cascadia-code-pl-fonts rsms-inter-fonts nerd-fonts wl-clipboard papirus-icon-theme network-manager-applet blueman pamixer starship foot fuzzel dunst aylurs-gtk-shell helix zellij hyprpaper hyprlock hypridle
```
End of installing dependencies:
```bash
pip install pywal
pip install psutil
sudo dnf install hyprland-git-devel hyprland-git --exclude kitty
```
Quality of life packages:
```bash 
sudo dnf copr enable tofik/nwg-shell
sudo dnf install nwg-look kvantum qt6ct zoxide cargo # Orchis as gtk and kvantum theme
```

## Installation

### Download
```bash
git clone https://github.com/dangooddd/.dotfiles.git
```

### Manual
Copy or symlink all directories you want

### Via script
> [!Warning]
> Method below may be dangerous! Some files from your filesystem can be deleted, so read code and make your decision!

Script will symlink dotfiles to your filesystem (existing directories will be moved in /path/to/dotfiles/.backup)
```bash
cd .dotfiles
./install.sh
```
