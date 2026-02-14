# hitori
{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # core
    ../../modules/core/base.nix
    ../../modules/core/users.nix

    # shared
    ../../modules/shared/networking.nix
    ../../modules/shared/security.nix
    ../../modules/shared/fonts
    ../../modules/shared/audio
    ../../modules/shared/podman
    ../../modules/shared/syncthing

    # desktop
    ../../modules/desktop/graphics
    ../../modules/desktop/gaming
    ../../modules/desktop/gui
    ../../modules/desktop/hyprland
  ];

  # Hostname
  networking.hostName = "hitori";

  # firmware updates for laptop/desktop hardware
  services.fwupd.enable = true;

  # firewall ports for Syncthing
  networking.firewall = {
    allowedTCPPorts = [ 8384 ];  # syncthing Web UI
    allowedUDPPorts = [ 9 ];     # wake-on-LAN
  };

  # appimage support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # State version (don't change after initial install)
  system.stateVersion = "25.11";
}
