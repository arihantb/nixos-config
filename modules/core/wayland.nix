/**
  This configuration sets up Hyprland (a modern dynamic tiling Wayland compositor) along with XDG desktop portals.
*/

{ inputs, pkgs, ... }:
{
  programs.hyprland = {
    # Enable Hyprland as the Wayland compositor.
    enable = true;

    # Use Hyprland from the flake input.
    package = inputs.hyprland.packages.${pkgs.system}.default;

    # Use the portal package provided by Hyprland.
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    # Enable XDG portal support (for sandboxed apps to communicate with the system).
    enable = true;

    # Force use of the potal for xdg-open (to open files/URLs with user apps).
    xdgOpenUsePortal = true;

    config = {
      # Set GTK as the default portal backend for all desktops.
      common.default = [ "gtk" ];

      hyprland.default = [
        # GTK portal for things like file choosers.
        "gtk"

        # Hyprland-specific portal for Wayland integration (screenshot, screenshare, etc.).
        "hyprland"
      ];
    };

    extraPortals = [
      # Include the GTK portal implementation.
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
