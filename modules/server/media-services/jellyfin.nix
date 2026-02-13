{config, pkgs, ...}:

{
    # Hardware acceleration for Jellyfin
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva
      libva-utils
      mesa
    ];
  };

  services.jellyfin = {
    enable = true;
    openFirewall = false;
    group = "media";
  };
}