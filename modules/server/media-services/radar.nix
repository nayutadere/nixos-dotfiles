{ config, lib, ... }:

let
  cfg = config.services.radarr;
  autheliaEnabled = config.services.authelia.instances != { };
in
{
  options.services.radarr = {
    enableCaddy = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "automatically configure caddy";
    };

    subdomain = lib.mkOption {
      type = lib.types.str;
      default = "radarr";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [{
      assertion = !cfg.enableCaddy || autheliaEnabled;
      message = "Radarr has a public vhost enabled but Authelia is not configured.";
    }];

    services.radarr = {
      openFirewall = false;
      group = "media";
    };

    services.caddy.virtualHosts = lib.mkIf (cfg.enableCaddy && autheliaEnabled) {
      "${cfg.subdomain}.${config.serverData.domain}".extraConfig = ''
        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:${toString cfg.settings.server.port}
      '';
    };
  };
}