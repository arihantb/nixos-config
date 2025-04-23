/**
  This configuration sets up the Hyprlock, a minimal lock screen for Hyprland.
*/

{ pkgs, ... }:
{
  # Custom config from './config.conf' to '~/.config/hypr/hyprlock.conf'.
  xdg.configFile."hypr/hyprlock.conf".source = ./config.conf;

  home.packages = with pkgs; [
    # A simple lock screen for Hyprland.
    hyprlock
  ];
}
