/**
  This configuration sets up a user account and integrates Home Manager.
*/

{
  hostname,
  inputs,
  pkgs,
  username,
  version,
  ...
}:
{
  imports = [
    # Import the Home Manager NixOS module.
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    # Allow user-specific packages to be managed by Home Manager.
    useUserPackages = true;

    # Share system-level `pkgs` with Home Manager (for consistency).
    useGlobalPkgs = true;

    extraSpecialArgs = { inherit inputs username hostname; };

    users.${username} = {
      # Import the user's Home Manager config (default.nix).
      imports = [ ./../home ];

      home = {
        # Set the Home Manager user.
        username = "${username}";

        # Set the user home directory.
        homeDirectory = "/home/${username}";

        # Set Home Manager state version (should match NixOS version).
        stateVersion = "${version}";
      };

      # Enable Home Manager itself for this user.
      programs.home-manager.enable = true;
    };
  };

  users.users.${username} = {
    # Mark the user as a standard login user (not a system account).
    isNormalUser = true;

    # Description of the user.
    description = "${username}";

    extraGroups = [
      # Grants permission to control networking via NetworkManager.
      "networkmanager"

      # Allows the user to use `sudo`.
      "wheel"
    ];

    # Set Zsh as the user's default shell.
    shell = pkgs.zsh;
  };

  nix.settings.allowed-users = [
    # Allow this user to use `nix` commands (e.g., `nix build`).
    "${username}"
  ];
}
