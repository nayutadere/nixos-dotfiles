{config, pkgs, ...}:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva
      libva-utils
      mesa
    ];
  };

  services.jellyfin = {
    enable = true;
    openFirewall = false;
    group = "media";
  };

  services.caddy.virtualHosts = {
    "jellyfin.${config.serverData.domain}".extraConfig = ''
      reverse_proxy localhost:8096
    '';
  };
}