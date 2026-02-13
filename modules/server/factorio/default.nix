{
  config,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "factorio-headless"
    ];

  services.factorio = {
    enable = true;
    openFirewall = true;

    game-name = "fucktorio";
    lan = true;

    extraSettings = {
      enemy_expansion = false;
      enemy_evolution = {
        time_factor = 0;
        pollution_factor = 0.0001;
        destroy_factor = 0.002;
      };
    };
  };
}
