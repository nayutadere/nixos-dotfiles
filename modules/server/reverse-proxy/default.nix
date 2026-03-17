# Reverse proxy module - Caddy with Authelia forward auth
{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.caddy = {
    enable = true;
    email = config.serverData.email; # For Let's Encrypt HTTPS certificates

    virtualHosts = {
      "auth.${config.serverData.domain}".extraConfig = ''
        reverse_proxy localhost:9091
      '';

      "notes.${config.serverData.domain}".extraConfig = ''
        forward_auth localhost:9091 {
            uri /api/authz/forward-auth
            copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:8085
      '';

      "prowlarr.${config.serverData.domain}".extraConfig = ''
        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:9696
      '';

      "neko.${config.serverData.domain}".extraConfig = ''
        reverse_proxy localhost:8090 {
          header_up X-Real-IP {remote_host}
          header_up X-Forwarded-For {remote_host}
          header_up X-Forwarded-Proto {scheme}
        }
      '';

      "qbit.${config.serverData.domain}".extraConfig = ''
        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:8080
      '';
    };
  };
}
