#!/bin/bash

LOGFILE="installation.log"

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
		sudo pacman -S "${package}" || { echo "Failed to install ${package}" >> $LOGFILE; exit 1; }
	fi
}

SHEL=("$SHELL")
TARGET="/usr/bin/nushell"

PACKAGES="git firefox neovim lsd neofetch ripgrep stow nushell"

echo "Starting installation..." > $LOGFILE

for package in $PACKAGES; do
	echo "Installing ${package}..." >> $LOGFILE
	_isInstalled "${package}" && _install "${package}"
done

if [ "${SHEL[*]}" != $TARGET ]; then
	echo "Changing shell to nushell..." >> $LOGFILE
	chsh -s /usr/bin/nushell || { echo "Failed to change shell" >> $LOGFILE; exit 1; }
fi

#Adding nvim config from Kornbor704/nvim-self-config
NVIMCONFIG=~/.config/nvim/

if [ -d "$NVIMCONFIG" ]; then
	echo "Removing existing nvim config..." >> $LOGFILE
	rm -rf $NVIMCONFIG || { echo "Failed to remove existing nvim config" >> $LOGFILE; exit 1; }
fi

echo "Cloning nvim config from Kornbor704/nvim-self-config..." >> $LOGFILE
git clone https://github.com/Konbor704/nvim-self-config.git ~/.config/nvim || { echo "Failed to clone nvim config" >> $LOGFILE; exit 1; }

echo "Installation completed." >> $LOGFILE
