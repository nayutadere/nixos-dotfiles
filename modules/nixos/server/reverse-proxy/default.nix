# Reverse proxy module - Caddy with Authelia forward auth
{ config, lib, pkgs, domain, email, ... }:

{
  services.caddy = {
    enable = true;
    email = email;  # For Let's Encrypt HTTPS certificates

    virtualHosts = {
      "auth.${domain}".extraConfig = ''
        reverse_proxy localhost:9091
      '';

      "dash.${domain}".extraConfig = ''
        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:3000
      '';

      "notes.${domain}".extraConfig = ''
        forward_auth localhost:9091 {
            uri /api/authz/forward-auth
            copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:8085
      '';

      "sonarr.${domain}".extraConfig = ''

        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:8989
      '';

      "radarr.${domain}".extraConfig = ''

        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:7878
      '';

      "prowlarr.${domain}".extraConfig = ''

        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:9696
      '';

      "bazarr.${domain}".extraConfig = ''

        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:6767
      '';

      "qbit.${domain}".extraConfig = ''
        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:8080
      '';

      #! Jellyfin and Jellyseerr need no auth
      "jellyfin.${domain}".extraConfig = ''
        reverse_proxy localhost:8096
      '';
      
      "requests.${domain}".extraConfig = ''
        reverse_proxy localhost:5055
      '';
    };
  };
}
