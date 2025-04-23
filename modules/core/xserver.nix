/**
  This configuration sets up a basic X11 (Xserver) desktop environment.
*/

{ username, ... }:
{
  services = {
    xserver = {
      # Enables the X11 display server needed for desktop environments or window managers using X11.
      enable = true;

      # Configures keyboard layouts: US (default).
      xkb.layout = "us";
    };

    displayManager.autoLogin = {
      # Enables automatic login on boot.
      enable = true;

      # Specifies which user to auto-login as.
      user = "${username}";
    };

    # Enables libinput for input device management (touchpads, mice, etc.).
    libinput.enable = true;
  };

  # Prevent long hangs during shutdown if a service takes too long.
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
