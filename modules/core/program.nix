/**
  This configuration is enabling some useful user-facing tools and system integration features.
*/

{ pkgs, ... }:
{
  programs = {
    # Required by many GNOME/GTK apps to store settings.
    dconf.enable = true;

    # Enable the Zsh shell.
    zsh.enable = true;

    gnupg.agent = {
      # Enable the GnuPG agent (for managing private keys, GPG signing, etc.).
      enable = true;

      # Allow GPG agent to act as an SSH agent (e.g., for Git or remote login).
      enableSSHSupport = true;

      # [Optional]: Uncomment the following to specify UI for passphrase entry (e.g., "qt", "curses", "gnome3").
      # pinentryFlavor = "";
    };

    # Allows running dynamically linked binaries not in the Nix store.
    nix-ld.enable = true;

    steam = {
      # Enables the steam.
      enable = true;

      # Open necessary firewall ports to support Steam Remote Play.
      remotePlay.openFirewall = true;

      # Keeps ports closed for running a dedicated Steam server.
      dedicatedServer.openFirewall = false;

      # Runs Steam within a Gamescope session (useful for Hyprland or special fullscreen handling).
      gamescopeSession.enable = true;

      extraCompatPackages = [
        # Adds compatibility layer (Proton-GE) to support Windows games on Steam.
        pkgs.proton-ge-bin
      ];
    };

    gamescope = {
      # A micro-compositor ideal for gaming and fullscreen applications.
      enable = true;

      # Allows Gamescope to change process priorities for better performances.
      capSysNice = true;

      args = [
        # Enables real-time scheduling for lower latency.
        "--rt"

        # Exposes the Wayland socket to apps inside the Gamescope session.
        "--expose-wayland"
      ];
    };

    obs-studio.package = (pkgs.obs-studio.override {
      # Adds Nvidia support to OBS Studio.
      cudaSupport = true;
    });
  };
}
