# Media services module
{
  config,
  ...
}:

{
  imports = [
    ./jellyfin.nix
    ./jellyseerr.nix
    ./bazarr.nix
    ./radar.nix
    ./sonar.nix
  ];

  services.radarr.enable = true;
  services.jellyfin.enable = true;

  users.groups.media = { };
}
