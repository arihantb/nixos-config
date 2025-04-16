#!/usr/bin/env bash

init() {
    # Vars
    CURRENT_USERNAME='arihant'
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

confirm() {
    echo -en "[${GREEN}y${NORMAL}/${RED}n${NORMAL}]: "
    read -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
}

print_header() {
    echo -E "$CYAN 
     _   _ _       ___        ___           _        _ _           
    | \ | (_)_  __/ _ \ ___  |_ _|_ __  ___| |_ __ _| | | ___ _ __ 
    |  \| | \ \/ / | | / __|  | || '_ \/ __| __/ _' | | |/ _ \ '__|
    | |\  | |>  <| |_| \__ \  | || | | \__ \ || (_| | | |  __/ |   
    |_| \_|_/_/\_\\\\___/|___/ |___|_| |_|___/\__\__,_|_|_|\___|_| 


                  $BLUE https://github.com/arihantb $RED 
      ! To make sure everything runs correctly DONT run as root ! $GREEN
                        -> '"./install.sh"' $NORMAL

    "
}

get_username() {
    echo -en "Enter your$GREEN username$NORMAL: $YELLOW"
    read username
    echo -en "$NORMAL"
    echo -en "Use$YELLOW "$username"$NORMAL as ${GREEN}username$NORMAL?"
    confirm
}

set_username() {
    sed -i -e "s/${CURRENT_USERNAME}/${username}/g" ./flake.nix
    sed -i -e "s/${CURRENT_USERNAME}/${username}/g" ./modules/home/audacious.nix
}

get_host() {
    echo -en "Enter your$GREEN hostname$NORMAL: $YELLOW"
    read hostname
    echo -en "$NORMAL"
    echo -en "Use $YELLOW "$hostname"$NORMAL as ${GREEN}hostname$NORMAL?"
    confirm
}

install() {
    echo -e "\n${RED}START INSTALL PHASE${NORMAL}\n"

    # Create basic directories
    echo -e "Creating folders:"
    echo -e "    - ${MAGENTA}~/Music${NORMAL}"
    echo -e "    - ${MAGENTA}~/Documents${NORMAL}"
    echo -e "    - ${MAGENTA}~/Pictures/wallpapers/others${NORMAL}"
    mkdir -p ~/Music
    mkdir -p ~/Documents
    mkdir -p ~/Pictures/wallpapers/others

    # Copy the wallpapers
    echo -e "Copying all ${MAGENTA}wallpapers${NORMAL}"
    cp -r wallpapers/wallpaper.png ~/Pictures/wallpapers
    cp -r wallpapers/otherWallpaper/gruvbox/* ~/Pictures/wallpapers/others/
    cp -r wallpapers/otherWallpaper/nixos/* ~/Pictures/wallpapers/others/

    # Get the hardware configuration
    echo -e "Copying ${MAGENTA}/etc/nixos/hardware-configuration.nix${NORMAL} to ${MAGENTA}./hosts/${HOST}/${NORMAL}\n"
    cp /etc/nixos/hardware-configuration.nix hosts/${HOST}/hardware-configuration.nix

    # Last Confirmation
    echo -en "You are about to start the system build, do you want to process?"
    confirm

    # Confirm the cores to use
    max_cores=$(nproc --all)
    echo -e "Enter the number of cores to use (1-$max_cores). (${GREEN}less cores${NORMAL}: slow but sufficient RAM, ${RED}more cores${NORMAL}: fast but may overflow RAM):"
    read cores

    # Ensure input is a number
    if ! [[ "$cores" =~ ^[0-9]+$ ]]; then
        echo "Please enter a valid number."
        exit 1
    fi

    if [[ "$cores" -lt 1 || "$cores" -gt "$max_cores" ]]; then
        echo -e "Incorrect number of cores. Please try again."
        exit 1
    fi

    # Build the system (flakes + home manager)
    echo -e "\nBuilding the system...\n"
    sudo nixos-rebuild switch --flake .#${HOST} --cores $cores
}

main() {
    init

    print_header

    get_username
    set_username
    get_host

    install
}

main && exit 0
