# Konze's dotfiles

## Setup macOS

```
git clone git@github.com:k0nze/dotfiles.git ${DOTFILES_REPO}
cd $HOME
mkdir -p .config
ln -s ${DOTFILES_REPO}/.config/yabai ~/.config/yabai
ln -s ${DOTFILES_REPO}/.config/skhd ~/.config/skhd
ln -s ${DOTFILES_REPO}/.tmux.conf ~/.tmux.conf
mkdir -p .config/karabiner
ln -s ${DOTFILES_REPO}/.config/karabiner ~/.config/karabiner/karabiner.json
```

```
brew install koekeishiya/formulae/yabai
brew install yabai
brew install skhd
brew install tmux
```

# Cheat Sheet
## shkd (macOS only)
### Change Window Focus

* `[left alt]+[h]`: change focus to the next windows on the left (west)
* `[left alt]+[j]`: change focus to the next windows on the bottom (south)
* `[left alt]+[k]`: change focus to the next windows on the top (north)
* `[left alt]+[l]`: change focus to the next windows on the right (east)

### Flip Windows Layout Along an Axis

* `[shift]+[left alt]+[x]`: flip windows along x-axis 
* `[shift]+[left alt]+[y]`: flip windows along y-axis

### Move Currently Focused Window to next Space
* `[shift]+[cmd]+[l]`: move focused window to the next space on the left
* `[shift]+[cmd]+[h]`: move focused window to the next space on the right

### Increase Size of Currently Focused Window
* `[shift]+[left ctrl]+[h]` increase window to the left
* `[shift]+[left ctrl]+[j]` increase window to the bottom
* `[shift]+[left ctrl]+[k]` increase window to the top
* `[shift]+[left ctrl]+[l]` increase window to the right

### Decrease Size of Currently Focused Window
* `[shift]+[left alt]+[h]` decrease window from the right
* `[shift]+[left alt]+[j]` decrease window from the top
* `[shift]+[left alt]+[k]` decrease window from the bottom
* `[shift]+[left alt]+[l]` decrease window from the left

