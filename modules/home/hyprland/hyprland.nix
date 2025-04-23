/**
  This configuration sets up Hyprland (a Wayland compositor) environment.
*/

{ inputs, pkgs, ... }:
{
  systemd.user.targets.hyprland-session.Unit.Wants = [
    # Ensures user services in '~/.config/autostart' are run when Hyprland starts.
    "xdg-desktop-autostart.target"
  ];

  wayland.windowManager.hyprland = {
    # Enable Hyprland as the window manager under Home Manager.
    enable = true;

    # Uses the system-level Hyprland package.
    package = null;

    # Uses system-defined portal package.
    portalPackage = null;

    xwayland = {
      # Enable support for legacy X11 apps inside Wayland (via XWayland).
      enable = true;
    };

    # Ensure Hyprland is launched and managed via systemd.
    systemd.enable = true;
  };

  home.packages = with pkgs; [
    # Clipboard manager for Wayland.
    cliphist

    # Auto-activates `.envrc` environments in directories (useful for dev workflows).
    direnv

    # Essential runtime library for many GUI applications.
    glib

    # Screenshot utility for Wayland (takes full or partial screenshots).
    grim

    # Color picker for Wayland, outputs hex/RGB from screen.
    hyprpicker

    # Hyprland helper tool for taking screenshots via grim/slurp.
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast

    # Lets you select a screen region used with grim for screenshots.
    slurp

    # Wallpaper daemon for Wayland used to set static or dynamic wallpapers.
    swww

    # Base Wayland protocols and libraries.
    wayland

    # Screen recording tool for Wayland.
    wf-recorder

    # Clipboard utility that persists clipboard contents across app closes.
    wl-clip-persist
  ];
}
