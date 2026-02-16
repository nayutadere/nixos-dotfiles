# shorekeeper
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
    ../../modules/shared/podman

    # server specific security
    ../../modules/server/security

    # server modules
    ../../modules/server/media-services
    ../../modules/server/authentication
    ../../modules/server/reverse-proxy
    ../../modules/server/dashboard
    ../../modules/server/containers
    ../../modules/server/minecraft
    ../../modules/server/factorio
    ../../modules/server/agenix
    ../../modules/server/searxng
    ../../modules/server/matrix
    ../../modules/server/anki
    ../../modules/server/ai
    # ../../modules/server/teamspeak
  ];

  networking.hostName = "shorekeeper";

  networking.firewall.allowedTCPPorts = [
    80
    443
    25565
    34197
  ];

  networking.firewall.allowedUDPPorts = [
    34197
  ];

  # nix-ld for running dynamic binaries
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    libva-utils     # hardware video acceleration utilities
    jdk21           # java for Minecraft
  ];

  # State version (don't change after initial install)
  system.stateVersion = "25.11";
}
