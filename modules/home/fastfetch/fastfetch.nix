/**
  This configuration sets up a fast and customisable system info tool.
 */

{ pkgs, ... }:
{
  # Enable fastfetch.
  home.packages = with pkgs; [ fastfetch ];

  # Custom config from './config.jsonc' to '~/.config/fastfetch/config.jsonc'.
  xdg.configFile."fastfetch/config.jsonc".source = ./config.jsonc;
}
