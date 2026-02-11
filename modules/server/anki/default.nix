{config, domain, ...}:
{
    services.anki-sync-server ={ 
        openFirewall = true;
        enable = true;
        address = "0.0.0.0";
        port = 27701;
        users = [
        {
            username = "nayuta";
            passwordFile = config.age.secrets.anki-secret.path;
        }
        ];
    };
    services.caddy = {
      virtualHosts = {
        "anki.${domain}".extraConfig = ''
          reverse_proxy localhost:27701
        '';
      };
    };
}
