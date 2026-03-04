# shared networking config
{ config, lib, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
  };

  services.resolved = {
    enable = true;
  };

  services.tailscale.enable = true;

  networking.firewall.enable = true;
}
