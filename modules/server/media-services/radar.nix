{config, ...}:

{
  services.radarr = {
    enable = true;
    openFirewall = false;
    group = "media";
  };

  services.caddy.virtualHosts = {
    "radarr.${config.serverData.domain}".extraConfig = ''

      forward_auth localhost:9091 {
        uri /api/authz/forward-auth
        copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
      }
      reverse_proxy localhost:7878
    '';
  };
}