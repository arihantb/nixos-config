/**
  This configuration sets up the Waybar status bar for Wayland compositor.
*/

{ pkgs, ... }:
{
  programs.waybar = {
    # Enable the Waybar.
    enable = true;

    package = pkgs.waybar.overrideAttrs (oa: {
      # Overrides the build attributes of the Waybar package to add a custom meson flag.
      mesonFlags = (oa.mesonFlags or [ ]) ++ [
        # Enables experimental features during build.
        "-Dexperimental=true"
      ];
    });
  };
}
