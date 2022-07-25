#!/bin/bash

base_packages="borg discord-canary celluloid audacity clementine chromium wine wine_gecko vim qbittorrent hexchat code archlinux-keyring yay"
aur_packages="spotify ttf-ms-fonts"

printf 'Do you wish to proceed with the script? (y/n)? '
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "Starting script.."
    sleep 1
    clear

    ## Preparing pacman

    sudo pacman-mirrors --fasttrack && sudo pacman -Syyu

    echo "Pacman mirrors have been set and the system has been upgraded."

    clear

    ## Installing base_packages

    sudo pacman --noconfirm --needed -S $base_packages

    echo "Base packages installed."
    clear

    ## Installing AUR packages

    yay --noconfirm --needed -S $aur_packages
    echo "AUR packages installed."
    clear

    ## Errors

    sudo systemctl --failed >> output1.txt

    sudo journalctl -p 3 -xb >> output2.txt

    ## Extras

    sudo systemctl enable fstrim.timer


else
    echo "Exiting.."
    exit 0
fi




