{config, ...}:

{
  services.bazarr = {
    enable = true;
    openFirewall = false;
    group = "media";
  };

  services.caddy.virtualHosts = {
    "bazarr.${config.serverData.domain}".extraConfig = ''

        forward_auth localhost:9091 {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
        reverse_proxy localhost:6767
      '';
  };
}