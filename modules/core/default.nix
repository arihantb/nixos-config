{ ... }:
{
  imports = [
    ./bluetooth.nix
    ./bootloader.nix
    ./fonts.nix
    ./graphics.nix
    ./hardware.nix
    ./network.nix
    ./nh.nix
    ./program.nix
    ./security.nix
    ./services.nix
    ./sound.nix
    ./swap.nix
    ./system.nix
    ./user.nix
    # ./virtualisation.nix
    # ./vpn.nix
    ./wayland.nix
    ./xserver.nix
  ];
}
