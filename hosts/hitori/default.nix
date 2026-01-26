# Host configuration for "hitori" (main desktop)
{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Modules
    ../../modules/nixos/common
    ../../modules/nixos/networking
<<<<<<< Updated upstream
    ../../modules/nixos/hyprland
    ../../modules/nixos/fonts
=======
    ../../modules/nixos/mangowc
>>>>>>> Stashed changes
  ];

  # Host-specific settings
  networking.hostName = "hitori";
}
