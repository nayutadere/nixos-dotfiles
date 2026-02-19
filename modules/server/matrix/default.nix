{ config, lib, ... }:

let
  cfg = config.services.shorekeeper.matrix;
in

{
  options.services.shorekeeper.matrix = {
    enable = lib.mkEnableOption "Matrix protocol for communication";
  };

  config = lib.mkIf cfg.enable {
    services.matrix-continuwuity = {
      enable = true;
      settings = {
        global = {
          server_name = config.serverData.domain;
          allow_registration = false;
          allow_encryption = true;
          allow_federation = true;
          trusted_servers = [ "matrix.org" ];
        };
      };
    };

    services.caddy = {
      virtualHosts."${config.serverData.domain}" = {
        extraConfig = ''
          # Federation: tells other servers where to connect
          handle /.well-known/matrix/server {
            header Content-Type application/json
            respond `{"m.server": "matrix.${config.serverData.domain}:443"}`
          }

          # Client: tells Matrix clients where to connect
          handle /.well-known/matrix/client {
            header Content-Type application/json
            header Access-Control-Allow-Origin "*"
            respond `{"m.homeserver": {"base_url": "https://matrix.${config.serverData.domain}"}}`
          }

          # Optional: if you want your base domain to show something else,
          # add other handlers here. Otherwise requests fall through.
        '';
      };

      virtualHosts."matrix.${config.serverData.domain}" = {
        extraConfig = ''
          reverse_proxy http://127.0.0.1:${toString 6167}
        '';
      };
    };
  };
}
