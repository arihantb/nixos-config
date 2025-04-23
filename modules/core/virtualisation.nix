/**
  This configuration sets up virtualisation support using libvert + QEMU + SPICE and installs related tools and drivers.
*/

{ pkgs, username, ... }:
{
  users.users.${username}.extraGroups = [
    # Grants user access to libvrt virtualisation features.
    "libvirtd"
  ];

  virtualisation = {
    libvirtd = {
      # Main virtualisation service for QEMU/KVM.
      enable = true;

      qemu = {
        # Enable Trusted Protocol Module (TPM) emulation for VMs.
        swtpm.enable = true;

        # Enable UEFI firmware support (for modern VM booting).
        ovmf.enable = true;

        ovmf.packages = with pkgs; [
          # Use the full-featured OVMF UEFI firmware image.
          OVMFFull.fd
        ];
      };
    };

    # Enable USB redirection for SPICE (pass USB devices into VMs).
    spiceUSBRedirection.enable = true;
  };

  # Run SPICE agent daemon for improved VM display, clipboard and resolution control.
  services.spice-vdagentd.enable = true;

  environment.systemPackages = with pkgs; [
    # Icon theme needed by some GTK virtualisation apps (like virt-manager).
    adwaita-icon-theme

    # SPICE protocol libraries (for high-performance VM display).
    spice

    # GTK bindings for SPICE (used by GUI apps).
    spice-gtk

    # Low-level SPICE communication definitions.
    spice-protocol

    # GUI tool to manage virtual machines (VMs).
    virt-manager

    # SPICE gues tools for Windows VMs (better input, display, etc.).
    win-spice

    # VirtIO drivers for Windows VMs (for better performance).
    win-virtio

  ];
}
