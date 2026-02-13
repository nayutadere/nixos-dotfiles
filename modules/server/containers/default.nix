# Container module - Podman and OCI containers
{
  config,
  lib,
  pkgs,
  ...
}:

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  systemd.services = {
    "podman-qbittorrent" = {
      wants = [ "podman-gluetun.service" ];
      after = [ "podman-gluetun.service" ];
      serviceConfig.RestartSec = "5s";
    };
    "podman-prowlarr" = {
      wants = [ "podman-gluetun.service" ];
      after = [ "podman-gluetun.service" ];
      serviceConfig.RestartSec = "5s";
    };
    "podman-flaresolverr" = {
      wants = [ "podman-gluetun.service" ];
      after = [ "podman-gluetun.service" ];
      serviceConfig.RestartSec = "5s";
    };
  };

  virtualisation.oci-containers.containers = {

    trilium = {
      image = "triliumnext/notes:latest";
      ports = [ "8085:8080" ];
      volumes = [
        "/var/lib/trilium:/home/node/trilium-data"
      ];
    };

    gluetun = {
      image = "qmcgaw/gluetun";
      environmentFiles = [ config.age.secrets.vpn-env.path ];
      ports = [
        "8080:8080" # qbittorrent
        "9696:9696" # prowlarr
        "8191:8191" # flaresolverr
      ];
      environment = {
        FIREWALL_OUTBOUND_SUBNETS = "192.168.1.0/24";
      };
      extraOptions = [
        "--privileged" # required, apparently
      ];
    };

    qbittorrent = {
      image = "linuxserver/qbittorrent";
      dependsOn = [ "gluetun" ];
      environment = {
        PUID = "1000";
        PGID = "1000";
      };
      volumes = [
        "/var/lib/qbittorrent:/config"
        "/mnt/media/downloads:/mnt/media/downloads"
        "/mnt/media:/mnt/media"
      ];
      extraOptions = [ "--network=container:gluetun" ];
    };

    prowlarr = {
      image = "linuxserver/prowlarr";
      dependsOn = [ "gluetun" ];
      environment = {
        PUID = "1000";
        PGID = "1000";
      };
      volumes = [
        "/var/lib/prowlarr:/config"
      ];
      extraOptions = [ "--network=container:gluetun" ];
    };

    flaresolverr = {
      image = "ghcr.io/flaresolverr/flaresolverr";
      dependsOn = [ "gluetun" ];
      environment = {
        LOG_LEVEL = "info";
      };
      extraOptions = [ "--network=container:gluetun" ];
    };
  };
}
