#!/usr/bin/env bash

init() {
    # Colors
    NORMAL=$(tput sgr0)
    WHITE=$(tput setaf 7)
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    BRIGHT=$(tput bold)
    UNDERLINE=$(tput smul)
}

safe_read() {
    read "$@" || {
        echo -e "\nInterrupted. Cleaning Up..."
        reset
    }
}

confirm() {
    echo -en "[${GREEN}y${NORMAL}/${RED}n${NORMAL}]: "
    safe_read -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        reset
        exit 0
    fi
}

create_files() {
    cp ./flake-.nix ./flake.nix
    cp ./modules/home/audacious-.nix ./modules/home/audacious.nix
}

print_header() {
    echo -E "$CYAN 
     _   _ _       ___        ___           _        _ _
    | \ | (_)_  __/ _ \ ___  |_ _|_ __  ___| |_ __ _| | | ___ _ __
    |  \| | \ \/ / | | / __|  | || '_ \/ __| __/ _' | | |/ _ \ '__|
    | |\  | |>  <| |_| \__ \  | || | | \__ \ || (_| | | |  __/ |
    |_| \_|_/_/\_\\\\___/|___/ |___|_| |_|___/\__\__,_|_|_|\___|_|


                  $BLUE https://github.com/arihantb $RED 
      ! To make sure everything runs correctly DON'T run as root ! $GREEN
                        -> '"./install.sh"' $NORMAL

    "
}

get_username() {
    echo -en "Enter your$GREEN username$NORMAL: $YELLOW"
    safe_read username
    echo -en "$NORMAL"
    echo -en "Use$YELLOW "$username"$NORMAL as ${GREEN}username$NORMAL?"
    confirm
}

set_username() {
    sed -i -e "s/\${username}/${username}/g" ./flake.nix
    sed -i -e "s/\${username}/${username}/g" ./modules/home/audacious.nix
}

get_host() {
    echo -en "Enter your$GREEN hostname$NORMAL: $YELLOW"
    safe_read hostname
    echo -en "$NORMAL"
    echo -en "Use $YELLOW "$hostname"$NORMAL as ${GREEN}hostname$NORMAL?"
    confirm
}

set_host() {
    sed -i -e "s/\${hostname}/${hostname}/g" ./flake.nix
}

create_directories() {
    echo -e "Creating folders:"
    echo -e "    - ${MAGENTA}~/Music${NORMAL}"
    echo -e "    - ${MAGENTA}~/Documents${NORMAL}"
    echo -e "    - ${MAGENTA}~/Pictures/wallpapers/others${NORMAL}"
    mkdir -p ~/Music
    mkdir -p ~/Documents
    mkdir -p ~/Pictures/wallpapers/others
}

copy_wallpapers() {
    echo -e "Copying all ${MAGENTA}wallpapers${NORMAL}"
    cp -r wallpapers/wallpaper.png ~/Pictures/wallpapers
    cp -r wallpapers/otherWallpaper/gruvbox/* ~/Pictures/wallpapers/others/
    cp -r wallpapers/otherWallpaper/nixos/* ~/Pictures/wallpapers/others/

}

get_default_conf() {
    echo -e "Copying ${MAGENTA}/etc/nixos/hardware-configuration.nix${NORMAL} to ${MAGENTA}./hosts/${hostname}/${NORMAL}"
    echo -e "Copying ${MAGENTA}/etc/nixos/configuration.nix${NORMAL} to ${MAGENTA}./hosts/${hostname}/${NORMAL}\n"
    mkdir -p hosts/${hostname}
    cp /etc/nixos/hardware-configuration.nix hosts/${hostname}/hardware-configuration.nix
    cp /etc/nixos/configuration.nix hosts/${hostname}/configuration.nix
}

get_cores() {
    max_cores=$(nproc --all)
    echo -e "Enter the number of cores to use (1-$max_cores). (${GREEN}less cores${NORMAL}: slow but sufficient RAM, ${RED}more cores${NORMAL}: fast but may overflow RAM):"
    safe_read cores

    if ! [[ "$cores" =~ ^[0-9]+$ ]]; then
        echo "Please enter a valid number."
        reset
        exit 1
    fi

    if [[ "$cores" -lt 1 || "$cores" -gt "$max_cores" ]]; then
        echo -e "Incorrect number of cores. Please try again."
        reset
        exit 1
    fi
}

install() {
    echo -e "\n${RED}START INSTALL PHASE${NORMAL}\n"

    create_directories
    copy_wallpapers
    get_default_conf

    echo -en "You are about to start the system build, do you want to process?"
    confirm

    get_cores

    echo -e "\nBuilding the system...\n"
    sudo nixos-rebuild switch --flake .#$hostname --cores $cores
}

restart() {
    echo -en "\n${GREEN}Installation Complete!${NORMAL} Reboot Now?"
    echo -en "[${GREEN}y${NORMAL}/${RED}n${NORMAL}]: "
    safe_read -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        reboot
        exit 0
    fi
}

reset() {
    rm -rf ./flake.nix
    rm -rf ./modules/home/audacious.nix
    exit 1
}

main() {
    init

    print_header

    create_files

    get_username
    set_username
    get_host
    set_host

    install

    restart
}

trap reset SIGINT
main && exit 0
