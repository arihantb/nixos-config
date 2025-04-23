{ inputs, ... }:
{
  imports = [
    ./config.nix
    ./hyprland.nix
    ./variables.nix
    inputs.hyprland.homeManagerModules.default
  ];
}
