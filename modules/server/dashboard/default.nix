# Dashboard module - Homepage dashboard
{ config, lib, pkgs, domain, ... }:

{
  services.homepage-dashboard = {
    enable = true;
    listenPort = 3000;
    environmentFile = config.age.secrets.homepage-env.path;
    allowedHosts = "dash.${domain}";

    settings = {
      title = "Shorekeeper";
      theme = "dark";
      color = "slate";
      headerStyle = "clean";
      background = {
        image = "https://w.wallhaven.cc/full/ml/wallhaven-mlqy18.png";
        blur = "md";
        brightness = 50;
      };
      layout = {
        Media = {
          style = "row";
          columns = 2;
        };
        Management = {
          style = "row";
          columns = 4;
        };
        Downloads = {
          style = "row";
          columns = 2;
        };
        Gaming = {
          style = "row";
          columns = 2;
        };
      };
    };

    services = [
      {
        "Media" = [
          {
            "Jellyfin" = {
              icon = "jellyfin.png";
              href = "https://jellyfin.${domain}";
              description = "Media Server";
              widget = {
                type = "jellyfin";
                url = "http://localhost:8096";
                key = "{{HOMEPAGE_VAR_JELLYFIN_API_KEY}}";
                enableBlocks = true;
              };
            };
          }
          {
            "Jellyseerr" = {
              icon = "jellyseerr.png";
              href = "https://requests.${domain}";
              description = "Media Requests";
              widget = {
                type = "jellyseerr";
                url = "http://localhost:5055";
                key = "{{HOMEPAGE_VAR_JELLYSEERR_API_KEY}}";
              };
            };
          }
        ];
      }
      {
        "Management" = [
          {
            "Sonarr" = {
              icon = "sonarr.png";
              href = "https://sonarr.${domain}";
              description = "TV Shows";
              widget = {
                type = "sonarr";
                url = "http://localhost:8989";
                key = "{{HOMEPAGE_VAR_SONARR_API_KEY}}";
              };
            };
          }
          {
            "Radarr" = {
              icon = "radarr.png";
              href = "https://radarr.${domain}";
              description = "Movies";
              widget = {
                type = "radarr";
                url = "http://localhost:7878";
                key = "{{HOMEPAGE_VAR_RADARR_API_KEY}}";
              };
            };
          }
          {
            "Bazarr" = {
              icon = "bazarr.png";
              href = "https://bazarr.${domain}";
              description = "Subtitles";
              widget = {
                type = "bazarr";
                url = "http://localhost:6767";
                key = "{{HOMEPAGE_VAR_BAZARR_API_KEY}}";
              };
            };
          }
          {
            "Prowlarr" = {
              icon = "prowlarr.png";
              href = "https://prowlarr.${domain}";
              description = "Indexer Manager";
              widget = {
                type = "prowlarr";
                url = "http://localhost:9696";
                key = "{{HOMEPAGE_VAR_PROWLARR_API_KEY}}";
              };
            };
          }
        ];
      }
      {
        "Downloads" = [
          {
            "qBittorrent" = {
              icon = "qbittorrent.png";
              href = "https://qbit.${domain}";
              description = "Torrent Client";
              widget = {
                type = "qbittorrent";
                url = "http://localhost:8080";
                username = "{{HOMEPAGE_VAR_QBIT_USER}}";
                password = "{{HOMEPAGE_VAR_QBIT_PASSWORD}}";
              };
            };
          }
          {
            "Gluetun" = {
              icon = "gluetun.png";
              description = "VPN Container";
            };
          }
        ];
      }
      {
        "Gaming" = [
          {
            "ATM10" = {
              icon = "minecraft.png";
              description = "Minecraft Server";
              widget = {
                type = "minecraft";
                url = "udp://localhost:25565";
              };
            };
          }
        ];
      }
    ];

    widgets = [
      {
        resources = {
          cpu = true;
          memory = true;
          disk = "/";
        };
      }
      {
        search = {
          provider = "duckduckgo";
          target = "_blank";
        };
      }
    ];

    bookmarks = [
      { "Admin" = [ { "Authelia" = [ { href = "https://auth.${domain}"; } ]; } ]; }
    ];
  };
}
