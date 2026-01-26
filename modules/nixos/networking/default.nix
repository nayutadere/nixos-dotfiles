{ config, lib, pkgs, ... }:
{
services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "opportunistic";
  };

  networking = {
    networkmanager.enable = true;
    nameservers = [ "9.9.9.9" "149.112.112.112"];

   # interfaces = {
   #   enp11s0 = {
   #     wakeOnLan.enable = true;
   #   };
   # };
    firewall = {
      allowedUDPPorts = [ 9 ];
      allowedTCPPorts = [ 8384 ];
    };
  };
}
