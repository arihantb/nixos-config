/**
  This configuration sets up a customized desktop environment.
*/

{ pkgs, ... }:
{
  # Enables fontconfig for proper font detection and usage by most Linux apps.
  fonts.fontconfig.enable = true;

  gtk = {
    # Enable GTK appearance.
    enable = true;

    font = {
      # Sets the UI font for GTK apps.
      name = "Maple Mono";

      # Sets the UI font size for GTK apps.
      size = 12;
    };

    theme = {
      # Applies a custom dark GTK theme.
      name = "Colloid-Green-Dark-Gruvbox";

      package = pkgs.colloid-gtk-theme.override {
        # Users the dark variant.
        colorVariants = [ "dark" ];

        # With green accent.
        themeVariants = [ "green" ];

        tweaks = [
          # Gruvbox color palette.
          "gruvbox"

          # Window borders removed.
          "rimless"

          # Floating-style layout.
          "float"
        ];
      };
    };

    iconTheme = {
      # Sets the icon theme.
      name = "Papirus-Dark";

      package = pkgs.papirus-icon-theme.override {
        # Uses black-colored variant.
        color = "black";
      };
    };

    cursorTheme = {
      # Sets GTK cursor to Bibata Modern Ice.
      name = "Bibata-Modern-Ice";

      # Define the package name.
      package = pkgs.bibata-cursors;

      # Cursor size in pixels.
      size = 24;
    };
  };

  home = {
    pointerCursor = {
      # Sets GTK cursor globally to Bibata Modern Ice.
      name = "Bibata-Modern-Ice";

      # Define the package name.
      package = pkgs.bibata-cursors;

      # Cursor size in pixels.
      size = 24;
    };

    packages = with pkgs; [
      # JetBrains Mono with Nerf Font icons.
      nerd-fonts.jetbrains-mono

      # Fira Code with Nerd Font icons.
      nerd-fonts.fira-code

      # Cascadia Code with Nerd Fonts.
      nerd-fonts.caskaydia-cove

      # Only symbols/icons used by Nerd Fonts.
      nerd-fonts.symbols-only

      # Twitter's colorful emoji font.
      twemoji-color-font

      # Google's emoji font.
      noto-fonts-emoji

      # A playful monospaced font.
      fantasque-sans-mono

      # Custom Maple Mono font with TrueType hinting.
      maple-mono.truetype-autohint
    ];
  };
}
