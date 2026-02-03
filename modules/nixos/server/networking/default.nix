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
    22
    80
    443
    25565
    7777
  ];
}
