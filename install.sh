#!/usr/bin/env bash

init() {
    # Variables
    CURRENT_USERNAME=`id -un`
    CURRENT_HOSTNAME=`hostname`
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
    echo -en "Enter your$GREEN username$NORMAL [${YELLOW}${CURRENT_USERNAME}${NORMAL}]: $YELLOW"
    safe_read username

    if [[ -z "$username" ]]; then
        username="$CURRENT_USERNAME"
    fi

    echo -en "$NORMAL"
    echo -en "Use$YELLOW "$username"$NORMAL as ${GREEN}username$NORMAL? "
    confirm
}

set_username() {
    sed -i -e "s/\${username}/${username}/g" ./flake.nix
}

get_host() {
    echo -en "Enter your$GREEN hostname$NORMAL [${YELLOW}${CURRENT_HOSTNAME}${NORMAL}]: $YELLOW"
    safe_read hostname

    if [[ -z "$hostname" ]]; then
        hostname="$CURRENT_HOSTNAME"
    fi

    echo -en "$NORMAL"
    echo -en "Use $YELLOW "$hostname"$NORMAL as ${GREEN}hostname$NORMAL? "
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

    echo -en "\nSetting up swap space\n"
    sudo mkdir -p /var/swap/
    sudo fallocate -l 8G /var/swap/swapfile > /dev/null 2>&1
    sudo chmod 600 /var/swap/swapfile > /dev/null 2>&1
    sudo mkswap /var/swap/swapfile > /dev/null 2>&1
    echo -en "Swap space sucessfully created!\n"
}

copy_wallpapers() {
    echo -e "\nCopying all ${MAGENTA}wallpapers${NORMAL}"
    cp -r wallpapers/wallpaper.png ~/Pictures/wallpapers
    cp -r wallpapers/otherWallpaper/gruvbox/* ~/Pictures/wallpapers/others/
    cp -r wallpapers/otherWallpaper/nixos/* ~/Pictures/wallpapers/others/
}

get_default_conf() {
    echo -e "Copying ${MAGENTA}/etc/nixos/hardware-configuration.nix${NORMAL} to ${MAGENTA}./hosts/${hostname}/${NORMAL}\n"
    mkdir -p hosts/${hostname}
    cp /etc/nixos/hardware-configuration.nix hosts/${hostname}/hardware-configuration.nix

    # Mounting ESP at /boot/efi instead of /boot: GRUB only
    sed -i -e "s/fileSystems\.\"\/boot\"/fileSystems\.\"\/boot\/efi\"/g" ./hosts/${hostname}/hardware-configuration.nix

    cp hosts/default.nix hosts/${hostname}/configuration.nix

    # File Not Found Error Fix
    git add .
}

get_opts() {
    max_cores=$(nproc --all)
    echo -en "\nEnter the number of cores to use (1-$max_cores). (${GREEN}less cores${NORMAL}: slow but sufficient RAM, ${RED}more cores${NORMAL}: fast but may overflow RAM): "
    safe_read cores

    if ! [[ "$cores" =~ ^[0-9]+$ ]]; then
        echo -e "Please enter a valid number."
        reset
        exit 1
    fi

    if [[ "$cores" -lt 1 || "$cores" -gt "$max_cores" ]]; then
        echo -e "Incorrect number of cores. Please try again."
        reset
        exit 1
    fi

    echo -en "Enter the number of max-jobs to use (1-6): "
    safe_read max_jobs

    if [[ "$max_jobs" -lt 1 || "$max_jobs" -gt 6 ]]; then
        echo -e "Incorrect number of max-jobs. Please try again."
        reset
        exit 1
    fi
}

setup_graphics() {
    ./modules/home/scripts/scripts/gpu-bus-id.sh > ./modules/core/gpu-bus-id.nix
}

install() {
    echo -e "\n${RED}START INSTALL PHASE${NORMAL}\n"

    create_directories
    copy_wallpapers
    get_default_conf

    echo -en "Do you wish to setup nvidia/amd graphics settings? "
    echo -en "[${GREEN}y${NORMAL}/${RED}n${NORMAL}]: "
    safe_read -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        setup_graphics
    else
        sed -i -e "s/\.\/nvidia\.nix/# \.\/nvidia\.nix/g" ./modules/core/default.nix
    fi

    echo -en "You are about to start the system build, do you want to process? "
    confirm

    get_opts

    echo -e "\nBuilding the system...\n"
    sudo nixos-rebuild switch --flake .#$hostname --upgrade-all --cores $cores --max-jobs $max_jobs
}

restart() {
    echo -en "\n${GREEN}Installation Complete!${NORMAL} Reboot Now? "
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
