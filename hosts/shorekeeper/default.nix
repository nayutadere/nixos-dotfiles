# Host configuration for "shorekeeper" (media server)
{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Server modules
    ../../modules/server/security
    ../../modules/server/networking
    ../../modules/server/users
    ../../modules/server/media-services
    ../../modules/server/authentication
    ../../modules/server/reverse-proxy
    ../../modules/server/dashboard
    ../../modules/server/containers
    ../../modules/server/minecraft
    ../../modules/server/factorio
    # ../../modules/server/syncthing
    ../../modules/server/copyparty
    ../../modules/server/agenix
    ../../modules/server/searxng
    # ../../modules/server/matrix
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
