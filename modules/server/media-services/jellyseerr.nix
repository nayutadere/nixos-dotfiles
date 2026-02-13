{
  config,
  ...
}:

{
  services.jellyseerr = {
    enable = true;
    openFirewall = false;
  };
}
