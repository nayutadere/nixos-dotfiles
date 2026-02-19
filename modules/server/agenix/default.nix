{ pkgs, inputs, ... }:
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  age.secrets = {
    vpn-env = {
      file = ../../../secrets/shorekeeper/vpn.env.age;
    };
    homepage-env = {
      file = ../../../secrets/shorekeeper/homepage.env.age;
    };
    authelia-jwt = {
      file = ../../../secrets/shorekeeper/authelia-jwt.age;
      owner = "authelia-main";
      mode = "0440";
    };
    authelia-storage = {
      file = ../../../secrets/shorekeeper/authelia-storage.age;
      owner = "authelia-main";
      mode = "0440";
    };
    authelia-session = {
      file = ../../../secrets/shorekeeper/authelia-session.age;
      owner = "authelia-main";
      mode = "0440";
    };
    searxng-secret = {
      file = ../../../secrets/shorekeeper/searxng-secret.age;
    };
    anki-secret = {
      file = ../../../secrets/shorekeeper/anki-password.age;
    };
    vpn-privateKey = {
      file = ../../../secrets/hitori/vpn.privateKey.age;
    };
    vpn-publicKey = {
      file = ../../../secrets/hitori/vpn.publicKey.age;
    };
    vpn-presharedKey = {
      file = ../../../secrets/hitori/vpn.presharedKey.age;
    };
  };
}
