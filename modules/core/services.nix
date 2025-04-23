/**
  This configuration sets up desktop-related services and behavior customizations.
*/

{ pkgs, ... }:
{
  services = {
    # Allows apps to access remote filesystem (like MTP, SMB, FTP) through GIO.
    gvfs.enable = true;

    gnome = {
      # Enable the GNOME TinySPARQL service (used by GNOME Tracker and search tools).
      tinysparql.enable = true;

      # Enable GNOME Keyring to securely store credentials and SSH keys.
      gnome-keyring.enable = true;
    };

    # Essential for interprocess communication in desktop environments.
    dbus.enable = true;

    # Enable weekly TRIM for SSDs - improves SSD lifespan and performance.
    fstrim.enable = true;

    dbus.packages = with pkgs; [
      # Adds GCR (GNOME Crypto library) to the D-Bus environment - needed for keyrings, certificates.
      gcr

      # Adds GNOME's settings daemon - required for consistent settings integration in some setups.
      gnome-settings-daemon
    ];
  };

  services.logind.extraConfig = ''
    # Override power button behavior - disables automatic shutdown on short press.
    HandlePowerKey=ignore
  '';
}
