#!/bin/bash

#INIT#
. /etc/os-release
sources_file="/etc/apt/sources.list"
os_list=("debian10" "debian11" "debian12" "ubuntu20" "ubuntu20.04" "ubuntu22" "ubuntu22.04")
os="$ID$VERSION_ID"

version="1.0"
author="WisePlace"

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
LGRAY="\e[37m"
GRAY="\e[90m"
LRED="\e[91m"
LGREEN="\e[92m"
LYELLOW="\e[93m"
LBLUE="\e[94m"
LMAGENTA="\e[95m"
LCYAN="\e[96m"
WHITE="\e[97m"
RESET="\e[0m"
BOLD="\e[1m"

os_check(){
    echo -e "${LCYAN}Current OS: $os${RESET}"
    for item in "${os_list[@]}"
    do
        if [ "$item" == "$os" ]
        then
            if [ ! -f "$sources_file" ]
            then
                touch "$sources_file"
            fi
            echo -e "${LGREEN}compatible sources are available.${RESET}"
            read -p "$(echo -e "${LCYAN}Do you want to install them ? Old sources will be commented ${LYELLOW}[Y/n]${LCYAN}:${RESET} ")" choice
            if [ "$choice" == y ] || [ "$choice" == Y ]
            then
                echo -e "${LYELLOW}Installing $ID $VERSION_ID sources..${RESET}"
                awk '!/^#/ {$0 = "# " $0} 1' "$sources_file" > tmpfile && mv tmpfile "$sources_file"
                sources_$ID$VERSION_ID
                echo -e "${LGREEN}New sources installed successfully.${RESET}"
                read -p "$(echo -e "${LCYAN}Do you want to update the packages ? ${LYELLOW}[Y/n]${LCYAN}:${RESET} ")" choice
                if [ "$choice" == y ] || [ "$choice" == Y ]
                then
                    echo -e "${LYELLOW}Updating packages..${RESET}"
                    apt update -y >/dev/null 2>&1
                    apt upgrade -y >/dev/null 2>&1
                    echo -e "${LGREEN}Packages updated successfully.${RESET}"
                    echo -e "${MAGENTA}Exiting..${RESET}"
                    exit 0
                fi
                echo -e "${MAGENTA}Exiting..${RESET}"
                exit 0
            fi
        fi
    done
    echo -e "${RED}No compatible sources for $ID $VERSION_ID.${RESET}"
    echo -e "${MAGENTA}Exiting..${RESET}"
    exit 1
}

sources_debian10(){
    echo "deb http://deb.debian.org/debian buster main contrib non-free" >> "$sources_file"
    echo "deb http://deb.debian.org/debian buster-updates main contrib non-free" >> "$sources_file"
    echo "deb http://deb.debian.org/debian buster-backports main contrib non-free" >> "$sources_file"
    echo "deb http://security.debian.org/debian-security/ buster/updates main contrib non-free" >> "$sources_file"
}

sources_debian11(){
    echo "deb http://deb.debian.org/debian bullseye main contrib non-free" >> "$sources_file"
    echo "deb http://deb.debian.org/debian bullseye-updates main contrib non-free" >> "$sources_file"
    echo "deb http://deb.debian.org/debian bullseye-backports main contrib non-free" >> "$sources_file"
    echo "deb http://security.debian.org/debian-security/ bullseye-security main contrib non-free" >> "$sources_file"
}

sources_debian12(){
    echo "deb http://deb.debian.org/debian/ bookworm contrib main non-free non-free-firmware" >> "$sources_file"
    echo "deb http://deb.debian.org/debian/ bookworm-updates contrib main non-free non-free-firmware" >> "$sources_file"
    echo "deb http://deb.debian.org/debian/ bookworm-proposed-updates contrib main non-free non-free-firmware" >> "$sources_file"
    echo "deb http://deb.debian.org/debian/ bookworm-backports contrib main non-free non-free-firmware" >> "$sources_file"
    echo "deb http://deb.debian.org/debian-security/ bookworm-security contrib main non-free non-free-firmware" >> "$sources_file"
}

sources_ubuntu20(){
    echo "deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.canonical.com/ubuntu focal partner" >> "$sources_file"
}

sources_ubuntu20.04(){
    echo "deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.canonical.com/ubuntu focal partner" >> "$sources_file"
}

sources_ubuntu22(){
    echo "deb http://archive.ubuntu.com/ubuntu/ jammy main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.ubuntu.com/ubuntu/ jammy-updates main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.ubuntu.com/ubuntu/ jammy-backports main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.canonical.com/ubuntu/ jammy partner" >> "$sources_file"
}

sources_ubuntu22.04(){
    echo "deb http://archive.ubuntu.com/ubuntu/ jammy main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.ubuntu.com/ubuntu/ jammy-updates main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.ubuntu.com/ubuntu/ jammy-backports main restricted universe multiverse" >> "$sources_file"
    echo "deb http://archive.canonical.com/ubuntu/ jammy partner" >> "$sources_file"
}

# EXEC #
os_check
