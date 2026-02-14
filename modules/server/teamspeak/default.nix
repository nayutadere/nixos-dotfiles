{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # create a dedicated user
  users.users.teamspeak = {
    isSystemUser = true;
    group = "teamspeak";
    home = "/var/lib/teamspeak";
    createHome = true;
  };
  users.groups.teamspeak = {};

  # run as a systemd service
  systemd.services.teamspeak = {
    description = "TeamSpeak Server";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.teamspeak_server}/bin/ts3server license_accepted=1 dbsqlpath=${pkgs.teamspeak_server}/lib/teamspeak/sql/";
      WorkingDirectory = "/var/lib/teamspeak";
      User = "teamspeak";
      Group = "teamspeak";
      Restart = "on-failure";
    };
  };

  # firewall
  networking.firewall.allowedUDPPorts = [ 9987 ];
  networking.firewall.allowedTCPPorts = [ 10011 30033 ];
}