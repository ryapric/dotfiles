#!/usr/bin/env bash
set -eu


if [ "$1" == "-u" ]; then
    if [ "$2" == "" ]; then
        echo "If pushing dotfile changes, you must provide a git commit message as the second argument. Aborting." >&2
        exit 1
    fi
    
    echo "Uploading dotfile settings..."
    
    # RStudio
    mkdir -p .rstudio-desktop/monitored/user-settings/
    cp ~/.rstudio-desktop/monitored/user-settings/user-settings .rstudio-desktop/monitored/user-settings/user-settings
    
    
    # Push all to git repo
    git add .
    git commit -m "$2"
    git push
elif [ "$1" == "-d" ]; then
    echo "Downloading dotfile settings..."
    git pull
else
    echo "You must pass either '-u' or '-d' flags. Aborting." >&2
    exit 1
fi


exit 0
