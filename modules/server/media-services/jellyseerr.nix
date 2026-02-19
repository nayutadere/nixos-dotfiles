{
  config,
  ...
}:

{
  services.jellyseerr = {
    enable = true;
    openFirewall = false;
  };

  services.caddy.virtualHosts = {
    "requests.${config.serverData.domain}".extraConfig = ''
      reverse_proxy localhost:5055
    '';
  };
}
