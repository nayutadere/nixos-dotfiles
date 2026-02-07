{ config, lib, pkgs, ... }:
{
#  services.resolved = {
 #   enable = true;
 #   dnssec = "true";
 #   dnsovertls = "opportunistic";
 # };

  networking = {
    networkmanager.enable = true;
    #nameservers = [ "9.9.9.10" "149.112.112.10" ]; # Quad9 DNS

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
