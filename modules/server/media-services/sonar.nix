{config, ...}:

{
  services.sonarr = {
    enable = true;
    openFirewall = false;
    group = "media";
  };
}