#!/bin/bash

_isInstalled() {
	package="$1"
	check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
	if [ -n "${check}" ]; then
		echo 0 #'0' means 'true' in Bash
		return #true
	fi
	echo 1 #'1' means 'false' in Bash
	return #false
}

# `_install <pkg>`
_install() {
	package="$1"

	# If the package IS installed:
	if [[ $(_isInstalled "${package}") == 0 ]]; then
		echo "${package} is already installed."
		return
	fi

	# If the package is NOT installed:
	if [[ $(_isInstalled "${package}") == 1 ]]; then
		sudo pacman -S "${package}"
	fi
}

SHEL=("$SHELL")
TARGET="/usr/bin/fish"

PACKAGES="fish git firefox neovim bat lsd neofetch ripgrep stow"

for package in $PACKAGES; do
	_isInstalled "${package}" && _install "${package}"
done

if [ "${SHEL[*]}" != $TARGET ]; then
	echo "Shell is not set as fish"
	chsh -s /usr/bin/fish
	curl -sS https://starship.rs/install.sh | sh
	echo "Shell is set as fish and stratship is installed"
else
	curl -sS https://starship.rs/install.sh | sh
	echo "Shell is set as fish and starship is already installed"
fi

#Adding Astronvim to NeoVim
ASTRONVIM=~/.config/nvim/lua/astronvim/

if [ -d "$ASTRONVIM" ]; then
	echo "Astronvim is already installed"
else
	git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
fi
