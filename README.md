# Konze's dotfiles

## zsh setup

install OhMyZsh:
```
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

install powerlevel10k:
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
change theme in `.zshrc`:
```
ZSH_THEME="powerlevel10k/powerlevel10k"
```
configure:
```
yyyy
Prompt Style: (3) Rainbow
Character Set: (1) Unicode
Show current time: (2) 24-hour-format
Prompt separators: (3) Slanted
Prompt Heads: (1) Sharp
Prompt Tails: (1) Flat
Prompt Height: (2) Two lines
Prompt Connection: (2) Dotted
Prompt Frame: (2) Left
Connection & Frame Color: (2) Light
Prompt Spacing: (1) Compact
Icons: (2) Many Icons
Prompt Flow: (1) Concise
Enable Transient Flow: (n)
Instant Prompt Mode: (2) Quiet
Y
```

install zsh-autosuggestions:
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
add to OhMyZsh plugins in `.zshrc`:
```
plugins=( 
    # other plugins...
    zsh-autosuggestions
)
```

## Setup macOS

```
git clone git@github.com:k0nze/dotfiles.git ${DOTFILES_REPO}
cd $HOME
mkdir -p .config
ln -s ${DOTFILES_REPO}/.config/nvim ~/.config/nvim
ln -s ${DOTFILES_REPO}/.config/yabai ~/.config/yabai
ln -s ${DOTFILES_REPO}/.config/skhd ~/.config/skhd
ln -s ${DOTFILES_REPO}/.tmux.conf ~/.tmux.conf
mkdir -p .config/karabiner
ln -s ${DOTFILES_REPO}/.config/karabiner ~/.config/karabiner/karabiner.json
```

```
brew install koekeishiya/formulae/yabai
brew install yabai
yabai --start-service
brew install koekeishiya/formulae/skhd
brew install skhd
skhd --start-service
brew install tmux neovim tree fzf ripgrep fd npm
```

## Setup Ubuntu
```
git clone git@github.com:k0nze/dotfiles.git ${DOTFILES_REPO}
cd $HOME
mkdir -p .config
ln -s ${DOTFILES_REPO}/.config/nvim ~/.config/nvim
```

```
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt update
sudo apt install tree fzf tmux ripgrep nodejs
sudo mkdir -p /opt/neovim/bin
sudo wget https://github.com/neovim/neovim/releases/download/${LATEST_VERSION}/nvim.appimage -O /opt/neovim/nvim.appimage
sudo chmod +x /opt/neovim/nvim.appimage 
sudo ln -s /opt/neovim/nvim.appimage /opt/neovim/bin/nvim
```

Extend `$PATH` in `~/.zshrc`
```
export PATH="/opt/neovim/bin:${PATH}"
```

## Font

CaskaydiaCoveNerdFont


# Cheat Sheet
## shkd (macOS only)
### Change Window Focus

* `[shift]+[left alt]+[h]`: change focus to the next windows on the left (west)
* `[shift]+[left alt]+[j]`: change focus to the next windows on the bottom (south)
* `[shift]+[left alt]+[k]`: change focus to the next windows on the top (north)
* `[shift]+[left alt]+[l]`: change focus to the next windows on the right (east)

### Flip Windows Layout Along an Axis

* `[shift]+[left alt]+[x]`: flip windows along x-axis 
* `[shift]+[left alt]+[y]`: flip windows along y-axis

### Increase Size of Currently Focused Window

* `[shift]+[left ctrl]+[h]` increase window to the left
* `[shift]+[left ctrl]+[j]` increase window to the bottom
* `[shift]+[left ctrl]+[k]` increase window to the top
* `[shift]+[left ctrl]+[l]` increase window to the right

## neovim
### Splitting a Window 

* `[space]+[%]` split window vertically
* `[space]+["]` split window horizontally
* `[space]+[=]` make splitted windows equal width
* `[ctrl]+[d]` close splitted window 

### Change Window Focus 

* `[space]+[h]`: change focus to the next windows on the left (west)
* `[space]+[j]`: change focus to the next windows on the bottom (south)
* `[space]+[k]`: change focus to the next windows on the top (north)
* `[space]+[l]`: change focus to the next windows on the right (east)

### Increase Size of Currently Focused Window

* `[space]+[m]`: maximize / restore current window size 

### Add / Remove Comments

* `[g]+[c]+[c]`: add / remove comment for current line
* `[g]+[c]+[NUM]+[j]`: add / remove comment for current and NUM lines below
* `[g]+[b]`: add / remove block comment for current selection

### File Explorer

* `[space]+[o]`: open and close file explorer 
* `[a]`: add a new file when in the file explorer window 
* `[ctrl]+[r]`: rename file that is currently selected 

### Telescope Fuzzy Finding

* TODO 

### Save and Close

* `[space]+[s]` save file
* `[space]+[q]` close file

### Auto-completion

### Code Navigation (lspsaga)

* `[g]+[f]` show definitions and references
* `[g]+[d]` go to declaration
* `[g]+[r]` show refernces
* `[g]+[i]` go to implementation

Finder navigation:
* `[j]` down
* `[k]` up
* `[o]` open

### Code Window / Minimap 

* `[space]+[m]+[m]` toggle on/off
* `[space]+[m]+[o]` enable
* `[space]+[m]+[c]` disable (TODO change to `m+q`)
* `[space]+[m]+[f]` focus / unfocus

[https://github.com/gorbit99/codewindow.nvim#configuration]()https://github.com/gorbit99/codewindow.nvim#configuration

### Tabs (bufferline)

* `[shift]+[h]` cycle to tab on the left 
* `[shift]+[l]` cycle to tab on the right
* `[shift]+[p]` cycle to previous tab 
* `[shift]+[n]` cycle to tab that was before previous 
* `[shift]+[q]` close current tab 

* `[ctrl]+[h]` move current tab to the left 
* `[ctrl]+[l]` move current tab to the left 

### Debugging nvim config

* Check if an LSP is running: `:lua print(vim.inspect(vim.lsp.get_active_clients()))`

[https://github.com/numToStr/Comment.nvim#configuration-optional](https://github.com/numToStr/Comment.nvim#configuration-optional)


## tmux
### Splitting a Window

* `[ctrl]+[b]+[%]` split window vertically
* `[ctrl]+[b]+["]` split window horizontally
* `[ctrl]+[d]` close splitted window 

# TODOs
## neovim

[ ] persist
[ ] telescope pick buffer 
[ ] lspsaga keymap 
[ ] python debugger (nvim-dap)
[ ] ipython notebooks, setup magma [https://github.com/dccsillag/magma-nvim](https://github.com/dccsillag/magma-nvim) (seems to be challenging to display images in the terminal)
[ ] outline for popups 
[ ] latex setup 
[ ] rust setup [https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/](https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/)
[ ] c setup 
[ ] c++ setup 


