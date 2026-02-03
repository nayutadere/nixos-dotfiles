# Host configuration for "hitori" (main desktop)
{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Modules
    ../../modules/nixos/common
    ../../modules/nixos/networking
    ../../modules/nixos/fonts
    ../../modules/nixos/audio
    ../../modules/nixos/graphics
    ../../modules/nixos/gaming
    ../../modules/nixos/gui
    ../../modules/nixos/hyprland
    # ../../modules/nixos/syncthing  # uncomment when needed
  ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # enable firmware updates
  services.fwupd.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";

  # host-specific settings
  networking.hostName = "hitori";
}
