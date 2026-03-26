{ config, lib, ... }:

let
  cfg = config.services.shorekeeper.navidrome;
in
{
  options.services.shorekeeper.navidrome = {
    enable = lib.mkEnableOption "Navidrome music server";
    musicFolder = lib.mkOption {
      type = lib.types.str;
      default = "/mnt/media/kani/Music";
      description = "Path to the music library";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.navidrome.serviceConfig.SupplementaryGroups = [ "syncthing" ];

    services.navidrome = {
      enable = true;
      settings = {
        Address = "127.0.0.1";
        Port = 4533;
        MusicFolder = cfg.musicFolder;
      };
    };

    services.caddy.virtualHosts."music.${config.serverData.domain}".extraConfig = ''
      reverse_proxy localhost:4533
    '';
  };
}
