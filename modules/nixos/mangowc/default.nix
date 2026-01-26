{ pkgs, ... }: {
  programs.mango.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      xfce.thunar-archive-plugin
      xfce.thunar-volman
      gnome-themes-extra
      adwaita-icon-theme
    ];
  };

  programs.yazi.enable = true;

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
  };

  environment.systemPackages = with pkgs; [
      foot #terminal
      swaybg # wallpaper
      fuzzel # app launcher
      waybar # status bar
      wl-clipboard #clipboard support
    ];

}
