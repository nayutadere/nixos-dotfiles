# Hyprland desktop environment module
{ config, lib, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  # Enable Wayland for Electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Hyprland ecosystem packages
  environment.systemPackages = with pkgs; [
    foot       # Terminal
    waybar     # Status bar
    swww       # Wallpaper (supports animations)
    hyprshot   # Screenshots
  ];
}
