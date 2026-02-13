# Networking module - DNS and VPN configuration
{ config, lib, pkgs, ... }:

{
  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "opportunistic";
  };

  networking = {
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    networkmanager.enable = true;
  };

  services.tailscale.enable = true;

  networking.firewall.allowedTCPPorts = [
    80
    443
    25565 #minecraft
    7777 #terraria
    34197 #factorio
  ];
}
