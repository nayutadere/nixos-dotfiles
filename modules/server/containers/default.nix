# Container module - Podman and OCI containers
{ config, lib, pkgs, ...}:

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  networking.firewall = {
    allowedTCPPorts = [ 8090 59000 ];
    allowedUDPPorts = [ 59000 ];
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

    neko = {
      image = "ghcr.io/m1k1o/neko/firefox:latest";
      ports = [
        "8090:8080"
        "59000:59000/udp"
        "59000:59000/tcp"
      ];
      environment = {
        NEKO_SCREEN = "1920x1080@60";
        NEKO_WEBRTC_TCPMUX = "59000";
        NEKO_WEBRTC_UDPMUX = "59000";
      };
      environmentFiles = [config.age.secrets.neko-env.path];
      extraOptions = [
        "--shm-size=2g"
        "--add-host=${config.serverData.domain}:192.168.1.208"
        "--add-host=jellyfin.${config.serverData.domain}:192.168.1.208"
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
