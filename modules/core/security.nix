/**
  This configuration sets up some important security-related services and integrations, particularly for graphical session locking and privilege management.
*/

{ ... }:
{
  security = {
    # Enable RealtimeKit - used to safely grant real-time CPU scheduling (important for audio apps like PipeWire).
    rtkit.enable = true;

    # Allows privilege escalation via `sudo` for users in the "wheel" group.
    sudo.enable = true;

    pam.services = {
      # Add PAM integration for swaylock (a screen locker for Wayland/Sway).
      swaylock = { };

      # Add PAM integration for hyprlock (a screen locaker for Hyprland).
      hyprlock = { };
    };
  };
}
