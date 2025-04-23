/**
  This configuration sets up graphics and media acceleration in the context of Hyprland.
*/

{ inputs, pkgs, ... }:
let
  # Import the nixpkgs used by Hyprland's flake, matching the host platform.
  # Makes sure the `mesa` version used is the one compatible with Hyprland.
  hyprland-pkgs = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  hardware = {
    graphics = {
      # Enable general hardware graphics support
      enable = true;

      # User Hyprland's version of mesa for compatibility with its ecosystem.
      package = hyprland-pkgs.mesa;

      extraPackages = with pkgs; [
        # Intel VA-API driver for newer Intel GPUs (Gen8+).
        # List of supported platforms: https://github.com/intel/media-driver/releases.
        # Check your platform: `lspci | grep -i vga`.
        intel-media-driver

        # Intel VA-API driver for older Intel GPUs.
        # List of supported platforms: https://www.intel.com/content/www/us/en/developer/articles/technical/linuxmedia-vaapi.html.
        # Check your platform: `lspci | grep -i vga`.
        # libva-intel-driver

        # VDPAU driver that uses VA-API for OpenGL-based systems; helpful for certain media players.
        libvdpau-va-gl

        # Provides a bridge between VA-API and VDPAU for broader compatibility.
        vaapiVdpau

        # Legacy Intel VA-API driver (for older chips); enable hybrid codecs like HEVC.
        (vaapiIntel.override { enableHybridCodec = true; })
      ];
    };

    # Allow installation of proprietary firmware blobs needed for GPU or some devices (like WiFi).
    enableRedistributableFirmware = true;
  };

}
