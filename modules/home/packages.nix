{ inputs, pkgs, ... }: 
{
  home.packages = (with pkgs; [
    ## CLI utility
    bluetui
    nixfmt-rfc-style                  # nix formatter
    playerctl                         # controller for media players
    poweralertd
    ripgrep                           # grep replacement
    shfmt                             # bash formatter
    swappy                            # snapshot editing tool
    texliveFull
    treefmt                           # project formatter
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
    evince
    file-roller
    filezilla
    libreoffice
    pavucontrol                       # pulseaudio volume controle (GUI)
    spotify
    thunderbird
    vlc
    wineWowPackages.wayland
    winetricks

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
