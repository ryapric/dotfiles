#!/usr/bin/env bash
set -e


if [ "$1" == "-u" ]; then
    if [ "$2" == "" ]; then
        echo "ERROR: If pushing dotfile changes, you must provide a git commit message as the second argument. Aborting." >&2
        exit 1
    fi

    echo "Uploading dotfile settings..."

    # RStudio
    echo "RStudio config..."
    mkdir -p .rstudio-desktop/monitored/user-settings/
    cp ~/.rstudio-desktop/monitored/user-settings/user-settings .rstudio-desktop/monitored/user-settings/user-settings
    echo "Done."

    # Spyder3
    echo "Spyder3 config..."
    mkdir -p .config/spyder-py3/
    cp ~/.config/spyder-py3/spyder.ini .config/spyder-py3/spyder.ini
    echo "Done."

    # Push all to git repo
    # [Should probably warn that 'git add .' is run]
    git add .
    git commit -m "$2"
    git push

elif [ "$1" == "-d" ]; then
    echo "Downloading dotfile settings..."
    git pull

    # General/bash
    if [ ! -e ~/.gitconfig ] || ! grep --quiet '[user]' ~/.gitconfig; then
        cat dot-gitconfig >> ~/.gitconfig
    fi

    if ! grep --quiet 'git_pull' ~/.bashrc; then
        cat git_pull >> ~/.bashrc
    fi

    # sed'ing to find the right PS1 line to replace is annoying, so just append and fix manually later, if desired (but you probably won't need to)
    cat PS1.txt >> ~/.bashrc

    # Compton
    echo "Compton config..."
    cp compton.conf ~/.config/compton.conf
    xfconf-query -c xfwm4 -p /general/use_compositing -s false
    cp compton.desktop ~/.config/autostart/compton.desktop
    echo "Done."

    # RStudio
    echo "RStudio config..."
    mkdir -p ~/.rstudio-desktop/monitored/user-settings/
    cp .rstudio-desktop/monitored/user-settings/user-settings ~/.rstudio-desktop/monitored/user-settings/user-settings
    echo "Done."

    # Spyder 3
    echo "Spyder 3 config..."
    mkdir -p ~/.config/spyder-py3/
    cp .config/spyder-py3/spyder.ini ~/.config/spyder-py3/spyder.ini
    echo "Done."

else
    echo "ERROR: You must pass either '-u' or '-d' flags, and 'u' needs a commit message. Aborting." >&2
    exit 1
fi


exit 0
