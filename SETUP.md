# Initial setup for dotfiles
There is some known-by-me problems with initial 
setup of these dotfiles on new machine.
There you can find steps to resolve these issues.

## Machine dependent configuration
Since I those dotfiles supposed to be managed by git,
machine dependent configuration (explain this later) should
be in .gitignore. Instructions below is provided after **install.sh script**

### Bar buttons are white or bar theme is awful
Set [Orchis GTK theme](https://github.com/vinceliuice/Orchis-theme).
You can try some others, but i find that [vinceliuice](https://github.com/vinceliuice) 
works best with any configs (sane defaults!)

### Bar language widget
After fresh install of dotfiles you will face
incorrect work (empty string) of language top bar widget.
To solve this problem you should find your keyboard name:
```bash
hyprctl devices
```
And then set this name into <u>~/.config/ags/user-options.js</u>.

If you can't find your keyboard, just try to place all of them one-by-one.

### Hyprland monitor scale
You can set any of hyprland settings in <u>~/.config/hypr/user/user-config.conf</u> and setup your monitor properly. 
Check [Hyprland Wiki](https://wiki.hyprland.org/).

### Hyprlock background
You can change background in <u>~/.config/hypr/user/user-variables.conf</u>
