{ pkgs, inputs, ... }:
{
  imports = [
    inputs.copyparty.nixosModules.default
  ];

  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];

  environment.systemPackages = [ pkgs.copyparty ];

  services.copyparty = {
    enable = true;
    settings = {
      p = [ 8081];
    };
  };
}
