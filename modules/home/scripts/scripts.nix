/**
  This configuration sets up custom shell scripts as user-executable commands.
 */

{ pkgs, ... }:
let
  ascii = pkgs.writeScriptBin "ascii" (builtins.readFile ./scripts/ascii.sh);
  compress = pkgs.writeScriptBin "compress" (builtins.readFile ./scripts/compress.sh);
  extract = pkgs.writeScriptBin "extract" (builtins.readFile ./scripts/extract.sh);
  maxfetch = pkgs.writeScriptBin "maxfetch" (builtins.readFile ./scripts/maxfetch.sh);
  power-menu = pkgs.writeScriptBin "power-menu" (builtins.readFile ./scripts/power-menu.sh);
  record = pkgs.writeScriptBin "record" (builtins.readFile ./scripts/record.sh);
  runbg = pkgs.writeShellScriptBin "runbg" (builtins.readFile ./scripts/runbg.sh);
  screenshot = pkgs.writeScriptBin "screenshot" (builtins.readFile ./scripts/screenshot.sh);
  show-keybinds = pkgs.writeScriptBin "show-keybinds" (builtins.readFile ./scripts/keybinds.sh);
  toggle_float = pkgs.writeScriptBin "toggle_float" (builtins.readFile ./scripts/toggle_float.sh);
  toggle_waybar = pkgs.writeScriptBin "toggle_waybar" (builtins.readFile ./scripts/toggle_waybar.sh);
in
{
  home.packages = [
    # Display the ASCII chart.
    ascii

    # Compress a file/folder.
    compress

    # Extract a compressed file.
    extract

    # Beautifully display user and system info.
    maxfetch

    # Show power options as rofi menu.
    power-menu

    # Screen record (screen, area, gif).
    record

    # Run a process as background.
    runbg

    # Take full screenshot.
    screenshot

    # Show Hyprland key bindings.
    show-keybinds

    # Float the current window in the middle of the screen.
    toggle_float

    # Show/Hide Waybar.
    toggle_waybar
  ];
}
