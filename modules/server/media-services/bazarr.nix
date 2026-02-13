{config, ...}:

{
  services.bazarr = {
    enable = true;
    openFirewall = false;
    group = "media";
  };
}