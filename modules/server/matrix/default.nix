{ config, pkgs, domain, ... }:

let
  matrixDomain = "matrix.${domain}";
  matrixPort = 6167;
in

{
  services.matrix-continuwuity = {
    enable = true;
    settings = {
      global = {
        server_name = domain;
        allow_registration = false;
        allow_encryption = true;
        allow_federation = true;
        trusted_servers = [ "matrix.org" ];
      };
    };
  };

  services.caddy = {
    virtualHosts."${domain}" = {
      extraConfig = ''
        # Federation: tells other servers where to connect
        handle /.well-known/matrix/server {
          header Content-Type application/json
          respond `{"m.server": "${matrixDomain}:443"}`
        }

        # Client: tells Matrix clients where to connect
        handle /.well-known/matrix/client {
          header Content-Type application/json
          header Access-Control-Allow-Origin "*"
          respond `{"m.homeserver": {"base_url": "https://${matrixDomain}"}}`
        }

        # Optional: if you want your base domain to show something else,
        # add other handlers here. Otherwise requests fall through.
      '';
    };

    virtualHosts."${matrixDomain}" = {
      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString matrixPort}
      '';
    };
  };

  # networking.firewall.allowedTCPPorts = [
  #   80
  #   443
  # ];
}
