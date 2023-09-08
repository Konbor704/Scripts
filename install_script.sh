#! /bin/bash

echo "Hello World!"

sudo pacman -Syu

sudo pacman -S fish firefox feh wal picom flameshot neovim git nemo kitty pavucontrol rofi

sudo pacman -S ttf-jetbrains-mono ttf-font-awesome ttf-nerd-fonts-symbols

sudo pacman -S --needed base-devel git

git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

nvm install node

nvm use latest

git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

git clone https://github.com/Konbor704/Astronvim.git ~/.config/nvim

git clone

mkdir ~/Documents/Coding
mkdir ~/Documents/Notes
mkdir ~/Wallpapers/
