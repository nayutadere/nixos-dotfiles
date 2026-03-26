# shorekeeper
{ config, lib, ... }:

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
    ../../modules/shared/syncthing

    # server specific security
    ../../modules/server/security

    # server modules
    ../../modules/server/vars
    ../../modules/server/media-services
    ../../modules/server/authentication
    ../../modules/server/reverse-proxy
    ../../modules/server/dashboard
    ../../modules/server/containers
    #../../modules/server/minecraft
    #../../modules/server/factorio
    ../../modules/server/agenix
    ../../modules/server/searxng
    ../../modules/server/matrix
    ../../modules/server/anki
    ../../modules/server/ai
    ../../modules/server/teamspeak
    ../../modules/server/terraria
    ../../modules/server/navidrome
  ];

  networking.hostName = "shorekeeper";

  services.shorekeeper.ai.enable = true;
  services.shorekeeper.navidrome.enable = true;

  networking.firewall.allowedTCPPorts = [
    80
    443
    25565
    34197
  ];

  networking.firewall.allowedUDPPorts = [
    34197
  ];

  networking.hosts = {
  "192.168.1.208" = [ "bocchide.re" "jellyfin.bocchide.re" ];
};

  # nix-ld for running dynamic binaries
  programs.nix-ld.enable = true;

  # State version (don't change after initial install)
  system.stateVersion = "25.11";
}
