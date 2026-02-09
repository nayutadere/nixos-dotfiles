{ config, pkgs, ... }:
{
  services.searx = {
    enable = true;
    environmentFile = config.age.secrets.searxng-secret.path;
    settings = {
      port = 8888;
      bind_address = "search.bocchide.re";
      general = {
        instance_name = "Bocchi Search";
      };

      server = {
        secret_key = config.age.secrets.searxng-secret.path;
      };
    };
  };
}
