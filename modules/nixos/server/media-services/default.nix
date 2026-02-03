# Media services module - Jellyfin and *arr stack
{ config, lib, pkgs, ... }:

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
  };

  services.sonarr = {
    enable = true;
  };

  services.radarr = {
    enable = true;
  };

  services.bazarr = {
    enable = true;
  };

  # Add service users to media group
  users.users.sonarr.extraGroups = [ "media" ];
  users.users.radarr.extraGroups = [ "media" ];
  users.users.bazarr.extraGroups = [ "media" ];
  users.users.jellyfin.extraGroups = [ "media" ];

  users.groups.media = { };
}
