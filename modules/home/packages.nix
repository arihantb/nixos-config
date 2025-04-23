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
    toipe                             # typing test in the terminal
    ttyper                            # cli typing test
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
    cbonsai                           # terminal screensaver
    cmatrix
    pipes                             # terminal screensaver
    sl
    tty-clock                         # cli clock

    ## GUI Apps
    audacity
    bleachbit                         # cache cleaner
    evince
    file-roller
    filezilla
    gimp
    gnome-calculator                  # calculator
    gnome-disk-utility
    ldtk                              # 2D level editor
    libreoffice
    mission-center                    # GUI resources monitor
    nix-prefetch-github
    obs-studio
    pavucontrol                       # pulseaudio volume controle (GUI)
    pitivi                            # video editing
    soundwireserver
    spotify
    thunderbird
    tiled                             # tile map editor
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
