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

  users.groups.media = { };
}
