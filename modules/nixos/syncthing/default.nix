# Syncthing file synchronization
{ config, lib, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "nayuta";
    dataDir = "/home/nayuta";
    openDefaultPorts = true;
  };
}
