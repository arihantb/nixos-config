/**
  This configuration sets up the network settings, the DNS and firewall settings.
*/

{ hostname, pkgs, ... }:
{
  networking = {
    # Set the system hostname dynamically from the `hostname` variable.
    hostName = "${hostname}";

    # Enable NetworkManager for managing network connections (WiFi, Ethernet, VPN, etc.).
    networkmanager.enable = true;

    # Set custom DNS servers for name resolution.
    nameservers = [
      # Google Public DNS.
      "8.8.8.8"

      # Google Public DNS (backup).
      "8.8.4.4"

      # Cloudflare DNS.
      "1.1.1.1"
    ];

    firewall = {
      # Enable the built-in NixOS firewall (iptables/nftables under the hood).
      enable = true;

      # Open specific TCP ports for incoming connections.
      allowedTCPPorts = [
        # SSH (for remote login).
        22

        # HTTP (web traffic).
        80

        # HTTPS (secure web traffic).
        443
      ];

      # [Optional]: Uncomment the following to open specific UDP ports for incoming connections.
      # allowedUDPPorts = [ ];
    };
  };

  environment.systemPackages = with pkgs; [
    # GUI applet for managing network connections.
    networkmanagerapplet
  ];
}
