/**
  This configuration sets up system-wide package maangement behavior, flakes, binary caches and basic system settings.
*/

{
  inputs,
  pkgs,
  version,
  ...
}:
{
  nix = {
    settings = {
      # Deduplicate Nix store paths automatically to save disk space.
      auto-optimise-store = true;

      experimental-features = [
        # Enables the modern CLI (`nix build`, `nix search`, etc.).
        "nix-command"

        # Enables flake support for reproducible builds and configuration.
        "flakes"
      ];

      substituters = [
        # Enables binary cache for gaming-related packages.
        "https://nix-gaming.cachix.org"

        # Enables binary cache for Hyprland packages.
        "https://hyprland.cachix.org"

        # Enables binary cache for Wezterm terminal.
        "https://wezterm.cachix.org"
      ];

      # Corresponding trusted keys for verifying binary caches.
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
      ];
    };
  };

  nixpkgs = {
    overlays = [
      # Adds the Nix User Repository (NUR) as a package overlay.
      inputs.nur.overlays.default
    ];
  };

  # System time zone.
  time.timeZone = "Asia/Kolkata";

  # System language/locale.
  i18n.defaultLocale = "en_US.UTF-8";

  # Allows installing unfree packages (e.g., Chrome, Steam).
  nixpkgs.config.allowUnfree = true;

  # System state version to match with NixOS version.
  system.stateVersion = "${version}";

  environment.systemPackages = with pkgs; [
    # Essential for version control and flakes.
    git
  ];
}
