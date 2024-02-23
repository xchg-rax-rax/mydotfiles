# mydotfiles

## Setup

First clone this repository into your home directory:
```bash
cd ~
git clone https://github.com/xchg-rax-rax/mydotfiles.git .dotfiles
```

Next make sure that `stow` is installed.

On arch:
```bash
sudo pacman -Syu stow
```

On Debian based distributions:
```bash
sudo apt update 
sudo apt upgrade
sudo apt install stow
```

Now we can use stow to load the dot files:
```bash
cd ~/.dotfiles
stow .
```

If this returns one or more errors, you may already have some of the dot files in this repo present. You can either move them, delete them or adopt them.
If you wish to adopt them (which will replace the dotfiles in this repo with the ones you already have) run the following:
```bash
cd ~/.dotfiles
stow . --adopt
```



