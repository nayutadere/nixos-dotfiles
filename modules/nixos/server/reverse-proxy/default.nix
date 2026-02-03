# Reverse proxy module - Caddy with Authelia forward auth
{ config, lib, pkgs, domain, email, ... }:

{
  services.caddy = {
    enable = true;
    email = email;  # For Let's Encrypt HTTPS certificates

    globalConfig = ''
      # Global rate limiting and security settings
      servers {
        # Limit concurrent connections per IP
        max_header_bytes 10KB

        # Prevent slowloris attacks
        read_timeout 10s
        write_timeout 20s
        idle_timeout 120s
      }
    '';

    virtualHosts = {
      # Auth portal - no forward_auth (would create loop)
      # More restrictive limits for public auth endpoint
      "auth.${domain}".extraConfig = ''
        # Limit request body size
        request_body {
          max_size 1MB
        }

        reverse_proxy localhost:9091
      '';

      # Dashboard - protected
      "dash.${domain}".extraConfig = ''
        # Limit request body size
        request_body {
          max_size 10MB
        }

        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:3000
      '';

      # Jellyfin - bypass (has own auth)
      "jellyfin.${domain}".extraConfig = ''
        # Larger limit for media streaming
        request_body {
          max_size 100MB
        }

        reverse_proxy localhost:8096
      '';

      # Jellyseerr - bypass (has own auth)
      "requests.${domain}".extraConfig = ''
        # Standard limit for request service
        request_body {
          max_size 10MB
        }

        reverse_proxy localhost:5055
      '';

      # Protected services
      "sonarr.${domain}".extraConfig = ''
        # Limit request body size for API calls
        request_body {
          max_size 50MB
        }

        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:8989
      '';

      "radarr.${domain}".extraConfig = ''
        # Limit request body size for API calls
        request_body {
          max_size 50MB
        }

        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:7878
      '';

      "prowlarr.${domain}".extraConfig = ''
        # Smaller limit for indexer manager
        request_body {
          max_size 10MB
        }

        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:9696
      '';

      "bazarr.${domain}".extraConfig = ''
        # Limit for subtitle service
        request_body {
          max_size 20MB
        }

        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:6767
      '';

      "qbit.${domain}".extraConfig = ''
        # Larger limit for torrent files
        request_body {
          max_size 100MB
        }

        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:8080
      '';

      "panel.${domain}".extraConfig = ''
        # Standard limit for panel
        request_body {
          max_size 10MB
        }

        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:9080
      '';

      "syncthing.${domain}".extraConfig = ''
        # Larger limit for file sync
        request_body {
          max_size 100MB
        }

        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:8384
      '';
    };
  };
}
