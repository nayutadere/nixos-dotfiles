# Reverse proxy module - Caddy with Authelia forward auth
{
  config,
  lib,
  pkgs,
  domain,
  email,
  ...
}:

{
  environment.etc."searxng-assets/logo.png".source = ./takobocchi.png;

  services.caddy = {
    enable = true;
    email = email; # For Let's Encrypt HTTPS certificates

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

      "data.${domain}".extraConfig = ''
        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:8081
      '';

      "search.${domain}".extraConfig = ''
        handle /static/themes/simple/img/searxng.png {
          rewrite * /logo.png
          root * /etc/searxng-assets
          file_server
        }

        reverse_proxy localhost:8888
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
