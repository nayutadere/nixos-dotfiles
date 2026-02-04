# Host configuration for "shorekeeper" (media server)
{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Server modules
    ../../modules/nixos/server/security
    ../../modules/nixos/server/networking
    ../../modules/nixos/server/users
    ../../modules/nixos/server/media-services
    ../../modules/nixos/server/authentication
    ../../modules/nixos/server/reverse-proxy
    ../../modules/nixos/server/dashboard
    ../../modules/nixos/server/containers
    ../../modules/nixos/server/minecraft
    ../../modules/nixos/server/factorio
    ../../modules/nixos/syncthing
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname
  networking.hostName = "shorekeeper";

  # nix-ld for dynamic binaries
  programs.nix-ld.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    tmux
    docker-compose
    libva-utils
    jdk21
    nixfmt
    wget
  ];

  # Nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
