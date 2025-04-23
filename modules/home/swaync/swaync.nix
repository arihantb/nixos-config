/**
  This configuration sets up a Wayland-native notification center.
*/

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Install Sway Notification Center.
    swaynotificationcenter
  ];

  xdg.configFile = {
    # Symlinks the custom CSS to '~/.config/swaync/style.css'.
    "swaync/style.css".source = ./style.css;

    # Symlinks the JSON config to '~/.config/swaync/config.json'.
    "swaync/config.json".source = ./config.json;
  };
}
