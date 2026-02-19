{config, ...}:

{
  services.sonarr = {
    enable = true;
    openFirewall = false;
    group = "media";
  };

  services.caddy.virtualHosts = {
    "sonarr.${config.serverData.domain}".extraConfig = ''

      forward_auth localhost:9091 {
        uri /api/authz/forward-auth
        copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
      }
      reverse_proxy localhost:8989
    '';
  };
}