{ config, lib, ... }:

let
  cfg = config.services.shorekeeper.searxng;
in
{
  options.services.shorekeeper.searxng = {
    enable = lib.mkEnableOption "SearXNG search engine with Caddy proxy";
  };

  config = lib.mkIf cfg.enable {
    environment.etc."searxng-assets/logo.png".source = ./takobocchi.png;

    services.searx = {
      enable = true;
      environmentFile = config.age.secrets.searxng-secret.path;
      settings = {
        port = 8888;
        bind_address = "127.0.0.1";
        general.instance_name = "BocchiSearch";
        server.secret_key = config.age.secrets.searxng-secret.path;
      };
    };

    services.caddy.virtualHosts."search.${config.serverData.domain}".extraConfig = ''
      handle /static/themes/simple/img/searxng.png {
        rewrite * /logo.png
        root * /etc/searxng-assets
        file_server
      }

      reverse_proxy localhost:8888
    '';
  };
}
