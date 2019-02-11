#!/usr/bin/env bash
set -e

# ln -r flag to make sure links are *relative*, i.e. path-expanded on set

# General/bash
echo "Setting symlink to .gitconfig..."
ln -frs dot-gitconfig ${HOME}/.gitconfig

# Compton
echo "Setting symlink to compton config..."
# Disable XFCE4 compositing, then set compton configs
if command -v compton > /dev/null; then
    xfconf-query -c xfwm4 -p /general/use_compositing -s false
fi
ln -frs compton.conf ${HOME}/.config/compton.conf
ln -frs compton.desktop ${HOME}/.config/autostart/compton.desktop

# RStudio
echo "Setting symlink to RStudio config..."
mkdir -p ${HOME}/.rstudio-desktop/monitored/user-settings/
ln -frs .rstudio-desktop/monitored/user-settings/user-settings ${HOME}/.rstudio-desktop/monitored/user-settings/user-settings

# Spyder 3
echo "Setting symlink to Spyder 3 config..."
mkdir -p ${HOME}/.config/spyder-py3/
ln -frs .config/spyder-py3/spyder.ini ${HOME}/.config/spyder-py3/spyder.ini

echo "Done."
exit 0
