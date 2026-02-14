{ config
, lib
, pkgs
, ...
}:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  # enable wayland for electron 'apps'
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # gui file manager
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs; [
        xfce.thunar-archive-plugin
        xfce.thunar-volman
        gnome-themes-extra
        adwaita-icon-theme
      ];
    };
    # cli file manager
    yazi.enable = true;
  };

  services = {
    gvfs.enable = true; # auto mounting drives
    tumbler.enable = true; # thumbnails on thunar
  };

  # minimal required packages
  environment.systemPackages = with pkgs; [
    foot         # terminal
    waybar       # status bar
    swaybg       # wallpaper
    fuzzel       # app start
    hyprshot     # screenshots
    wl-clipboard # clipboard support
  ];
}
