{ inputs, pkgs, ... }: 
{
  home.packages = (with pkgs; [
    ## CLI utility
    ast-grep
    bluetui
    fd
    fish
    ghostscript
    mermaid-cli
    nixfmt-rfc-style                  # nix formatter
    nodejs_23
    playerctl                         # controller for media players
    poweralertd
    ripgrep                           # grep replacement
    shfmt                             # bash formatter
    sqlite
    swappy                            # snapshot editing tool
    texliveFull
    treefmt                           # project formatter
    tree-sitter
    tldr
    todo                              # cli todo list
    unzip
    wavemon                           # monitoring for wireless network devices
    wl-clipboard                      # clipboard utils for wayland (wl-copy, wl-paste)
    wget
    xdg-utils
    xxd

    ## CLI 
    sl
    tty-clock                         # cli clock

    ## GUI Apps
    # PDF Viewer
    evince
    beamerpresenter

    blueman

    # Zip File Manager
    file-roller

    # Document Writer
    libreoffice

    # Formula 1 TV
    multiviewer-for-f1

    # File Manager
    nemo

    # Netflix
    netflix

    obs-studio

    pavucontrol                       # pulseaudio volume controle (GUI)
    spotify

    # Video Torrent Streaming
    stremio
    thunderbird
    vlc

    # Video Conferencing
    zoom-us

    # C / C++
    gcc
    gdb
    cmake
    gnumake
    llvmPackages_20.clang-tools

    inputs.alejandra.defaultPackage.${system}

    drawio

    wineWowPackages.waylandFull
  ]);
}
