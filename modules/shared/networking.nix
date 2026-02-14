# shared networking config
{ config, lib, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  services.resolved = {
    enable = true;

    settings = {
      Resolve = {
        # validate DNS responses
        # DNSSEC = "true";

        # # try to encrypt DNS queries
        # DNSOverTLS = "opportunistic";
      };
    };
  };

  networking.nameservers = [
    "9.9.9.10"
    "149.112.112.10"
  ];

  # ssh
  services.tailscale.enable = true;

  networking.firewall = {
    enable = true;

    # device specific
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };
}
