/**
  This configuration sets the environment variables to optimize and ensure compatibility for various apps running on a Wayland compositor.
*/

{ ... }:
{
  home.sessionVariables = {
    # Enables Wayland support in Anki.
    ANKI_WAYLAND = 1;

    # Forces Clutter-based apps (e.g., GNOME apps) to use Wayland.
    CLUTTER_BACKEND = "wayland";

    # Silences direnv logging.
    DIRENV_LOG_FORMAT = "";

    # Enables Qt5 compatibility.
    DISABLE_QT5_COMPAT = 0;

    # GTK apps will use Wayland instead of X11.
    GDK_BACKEND = "wayland";

    # Ensures grimblast doesn't hide the cursor during screenshots.
    GRIMBLAST_HIDE_CURSOR = 0;

    # GTK theme for GTK-based applications.
    GTK_THEME = "Colloid-Green-Dark-Gruvbox";

    # Enables Wayland support in Firefox/Thunderbird.
    MOZ_ENABLE_WAYLAND = 1;

    # Enables Wayland support in Chromium/Electron apps.
    NIXOS_OZONE_WL = 1;

    # Enables automatic scaling for high-DPI displays in Qt apps.
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;

    # Forces Qt apps to use X11.
    QT_QPA_PLATFORM = "xcb";

    # Uses qt5ct to control the appearance of Qt applications.
    QT_QPA_PLATFORMTHEME = "qt5ct";

    # Overrides the Qt style with Kvantum theme engine.
    QT_STYLE_OVERRIDE = "kvantum";

    # Disables client-side decorations in Qt Wayland apps (enables server-side).
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;

    # Forces SDL-based apps to use Wayland.
    SDL_VIDEODRIVER = "wayland";

    # Points to the SSH agent socket, enabling key-based SSH.
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";

    # Uses Vulkan backend for wlroots-based compositors (like Hyprland).
    WLR_BACKEND = "vulkan";

    # Disables atomic mode-setting (sometimes needed for compatibility).
    WLR_DRM_NO_ATOMIC = 1;

    # Forces software rendering of cursor (fixes issues with some drivers).
    WLR_NO_HARDWARE_CURSORS = 1;

    # Specifies Vulkan renderer for Wayland compositors.
    WLR_RENDERER = "vulkan";

    # Sets the current desktop environment to Hyprland.
    XDG_CURRENT_DESKTOP = "Hyprland";

    # Sets the session desktop name to Hyprland.
    XDG_SESSION_DESKTOP = "Hyprland";

    # Specifies session type is Wayland.
    XDG_SESSION_TYPE = "wayland";

    # Improves Java app compatibility under non-reparenting WMs like Wayland.
    _JAVA_AWT_WM_NONEREPARENTING = 1;

    # Disables G-Sync (Nvidia variable).
    __GL_GSYNC_ALLOWED = 0;

    # Disables Variable Refresh Rate (VRR) (Nvidia variable).
    __GL_VRR_ALLOWED = 0;
  };
}
