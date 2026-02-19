{config, lib, pkgs, ...}:

let
  cfg = config.services.jellyfin;
in
{
  options.services.jellyfin = {
    enableCaddy = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "automatically configure caddy";
    };

    subdomain = lib.mkOption {
      type = lib.types.str;
      default = "jellyfin";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
          libva
          libva-utils
          mesa
        ];
      };

      services.jellyfin = {
        openFirewall = false;
        group = "media";
      };

      services.caddy.virtualHosts = lib.mkIf (cfg.enableCaddy) {
        "${cfg.subdomain}.${config.serverData.domain}".extraConfig = ''
          reverse_proxy localhost:8096
        '';
      };
      #${toString cfg.settings.server.port} module doesn't expose port
  };
}