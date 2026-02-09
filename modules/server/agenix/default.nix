{ pkgs, inputs, ... }:
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  age.secrets = {
    vpn-env = {
      file = ../../../secrets/vpn.env.age;
    };
    homepage-env = {
      file = ../../../secrets/homepage.env.age;
    };
    authelia-jwt = {
      file = ../../../secrets/authelia-jwt.age;
      owner = "authelia-main";
      mode = "0440";
    };
    authelia-storage = {
      file = ../../../secrets/authelia-storage.age;
      owner = "authelia-main";
      mode = "0440";
    };
    authelia-session = {
      file = ../../../secrets/authelia-session.age;
      owner = "authelia-main";
      mode = "0440";
    };
    searxng-secret = {
      file = ../../../secrets/searxng-secret.age;
    };
  };
}
