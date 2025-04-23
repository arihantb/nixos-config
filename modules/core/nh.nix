/**
  This configuration smoothes out the developer/operator experience with easy flake management, automated cleaning and better builds and debugging.
*/

{ username, ... }:
{
  programs.nh = {
    # Enable the `nh` tool (Nix Helper), which simplifies flake-based NixOS management.
    enable = true;

    clean = {
      # Automatically clean up old generations of system profiles.
      enable = true;

      # Keep generations from the past 7 days and at least 5 total.
      extraArgs = "--keep-since 7d --keep 5";
    };

    # Path to the flake used for system configuration.
    flake = "/home/${username}/nixos-config";
  };
}
