# Host configuration for "hitori" (main desktop)
{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Modules
    ../../modules/nixos/common
    ../../modules/nixos/networking
    ../../modules/nixos/hyprland
  ];

  # Host-specific settings
  networking.hostName = "hitori";
}
