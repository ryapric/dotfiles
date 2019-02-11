SHELL = /usr/bin/env bash

# Check who's running this, so permissions are set accordingly
# Needs -E flag so xfconf runs under sudo
dotfiles:
	@if [ -z "$$SUDO_USER" ]; then MAKE_USER="$$USER"; else MAKE_USER="$$SUDO_USER"; fi; \
	sudo -E -u $$MAKE_USER bash dotfiles.sh
