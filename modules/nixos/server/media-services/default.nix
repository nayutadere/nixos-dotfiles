# Media services module - Jellyfin and *arr stack
{
  config,
  lib,
  pkgs,
  ...
}:

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
    openFirewall = true;
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
  };

  services.bazarr = {
    enable = true;
    openFirewall = true;
  };

  # Add service users to media group
  users.users.sonarr.extraGroups = [ "media" ];
  users.users.radarr.extraGroups = [ "media" ];
  users.users.bazarr.extraGroups = [ "media" ];
  users.users.jellyfin.extraGroups = [ "media" ];

  users.groups.media = { };

  # Ensure media directories are owned by the media group so that native
  # services (sonarr, radarr, jellyfin …) can read files written by the
  # qBittorrent container (which runs as UID 1000).
  # "d" = directory, "a" = apply recursively, 0775 = rwxrwxr-x, "media" = group.
  systemd.tmpfiles.rules = [
    "d /mnt/media            0775 root media - -"
    "d /mnt/media/downloads  0775 root media - -"
    "d /mnt/media/incomplete 0775 root media - -"
  ];
}
