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
    #../../modules/shared/security.nix # breaks anti-cheat (kernel hardening)
    ../../modules/shared/fonts
    ../../modules/shared/audio
    ../../modules/shared/podman
    ../../modules/shared/syncthing

    # desktop
    #../../modules/desktop/vpn
    ../../modules/desktop/graphics
    ../../modules/desktop/gaming
    ../../modules/desktop/gui
    #../../modules/desktop/hyprland
    ../../modules/desktop/kdeplasma
  ];

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

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/9f50cec9-83f1-48b2-b03b-d42a21f53cdc";
    fsType = "ext4";  # or ntfs, exfat, btrfs, etc.
    options = [ "defaults" "nofail" ];  # nofail = don't halt boot if drive missing
  };

  services.flatpak.enable = true;
  programs.nix-ld.enable = true;

  # State version (don't change after initial install)
  system.stateVersion = "25.11";
}
