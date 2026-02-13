{config, ...}:

{
  services.radarr = {
    enable = true;
    openFirewall = false;
    group = "media";
  };
}