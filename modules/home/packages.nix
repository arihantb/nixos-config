{ inputs, pkgs, ... }: 
{
  home.packages = (with pkgs; [
    ## CLI utility
    bluetui
    file                              # Show file information 
    htop
    nixfmt-rfc-style                  # nix formatter
    playerctl                         # controller for media players
    poweralertd
    ripgrep                           # grep replacement
    shfmt                             # bash formatter
    swappy                            # snapshot editing tool
    tdf                               # cli pdf viewer
    texlive
    treefmt                           # project formatter
    tldr
    todo                              # cli todo list
    unzip
    valgrind                          # c memory analyzer
    wavemon                           # monitoring for wireless network devices
    wl-clipboard                      # clipboard utils for wayland (wl-copy, wl-paste)
    wget
    woomer
    yt-dlp-light
    xdg-utils
    xxd

    ## CLI 
    sl
    tty-clock                         # cli clock

    ## GUI Apps
    audacity
    bleachbit                         # cache cleaner
    evince
    file-roller
    filezilla
    gimp
    gnome-disk-utility
    libreoffice
    nix-prefetch-github
    obs-studio
    pavucontrol                       # pulseaudio volume controle (GUI)
    spotify
    thunderbird
    vlc
    wineWowPackages.wayland
    winetricks
    zenity

    # C / C++
    gcc
    gdb
    cmake
    gnumake
    llvmPackages_20.clang-tools

    # Zig
    # inputs.zig.packages.${system}.master
    # zls

    # Python
    python3
    python312Packages.ipython

    inputs.alejandra.defaultPackage.${system}
  ]);
}
