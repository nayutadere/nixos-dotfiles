# Authentication module - Authelia SSO
{ config, lib, pkgs, domain, ... }:

{
  services.authelia.instances.main = {
    enable = true;
    secrets = {
      # agenix decrypts these at activation; paths are in /run/agenix/.
      jwtSecretFile             = config.age.secrets.authelia-jwt.path;
      storageEncryptionKeyFile  = config.age.secrets.authelia-storage.path;
      sessionSecretFile         = config.age.secrets.authelia-session.path;
    };
    settings = {
      theme = "dark";
      default_2fa_method = "totp";

      server.address = "tcp://127.0.0.1:9091";

      log = {
        level = "info";
        format = "text";
      };

      authentication_backend.file = {
        path = "/var/lib/authelia-main/users_database.yml";
        password.algorithm = "argon2id";
      };

      access_control = {
        default_policy = "deny";
        rules = [
          {
            domain = "jellyfin.${domain}";
            policy = "bypass";
          }
          {
            domain = "qbit.${domain}";
            policy = "bypass";
          }
          {
            domain = "requests.${domain}";
            policy = "bypass";
          }
          {
            domain = "*.${domain}";
            policy = "one_factor";
          }
        ];
      };

      session = {
        cookies = [
          {
            domain = domain;
            authelia_url = "https://auth.${domain}";
            expiration = "12h";
            inactivity = "45m";
          }
        ];
      };

      regulation = {
        max_retries = 3;
        find_time = "2m";
        ban_time = "10y";
      };

      storage.local.path = "/var/lib/authelia-main/db.sqlite3";

      notifier.filesystem.filename = "/var/lib/authelia-main/notification.txt";
    };
  };
}
