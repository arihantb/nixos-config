/**
  This configuration sets up Console-based Audio Visualiser for ALSA.
*/

{ ... }:
{
  # Enables the terminal-based audio visualiser.
  programs.cava.enable = true;

  # Custom CAVA configuration from './config.txt' to '~/.config/cava/config'.
  xdg.configFile."cava/config".source = ./config.txt;
}
