/**
  This configuration sets up the bootloader as GRUB in EFI mode and configuring its theme.
*/

{
  inputs,
  pkgs,
  system,
  ...
}:
{
  boot = {
    # Use the 'zen' kernel variant, which is a performance-tuned version of the Linux kernel.
    kernelPackages = pkgs.linuxPackages_zen;

    # [Optional]: Uncomment the following to add support for NTFS file system (e.g., useful for mounting Windows partitions).
    # supportedFilesystems = [ "ntfs" ];

    loader = {
      efi = {
        # Allow NixOS to write EFI firmware variables (e.g., to set boot order or entries).
        canTouchEfiVariables = true;

        # Mount point for the EFI System Partition (ESP); this should match `fstab` or `hardware-configuration.nix`.
        efiSysMountPoint = "/boot/efi";
      };

      grub = rec {
        # Enable the GRUB bootloader.
        enable = true;

        # Tell GRUB to install in EFI mode (not legacy BIOS).
        efiSupport = true;

        # [Optional]: Uncomment the following if `canTouchEfiVariables` doesn't work - installs GRUB as a removable bootloader.
        # efiInstallAsRemovable = true;

        # 'nodev' means GUB won't install to a physical device - instead, it goes to the ESP via EFI.
        device = "nodev";

        # Keep only the latest 10 system generations in the GRUB boot menu.
        configurationLimit = 10;

        # Set a custom GRUB theme.
        theme = inputs.distro-grub-themes.packages.${system}.msi-grub-theme;

        # Background splash image.
        splashImage = "${theme}/splash_image.jpg";
      };
    };
  };
}
