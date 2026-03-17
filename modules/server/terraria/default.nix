{ config, lib, pkgs, ... }:

let
  terraria-server = pkgs.callPackage ./package.nix {};

  dataDir = "/var/lib/terraria";

  serverConfig = builtins.toFile "terraria.cfg" ''
    world=${dataDir}/world.wld
    worldname=balls
    autocreate=3
    difficulty=2
    maxplayers=8
    motd=Welcome!
    port=7777
    noupnp=1
  '';
in
{
  users.users.terraria = {
    group = "terraria";
    home = dataDir;
    isSystemUser = true;
    uid = config.ids.uids.terraria;
  };

  users.groups.terraria = {
    gid = config.ids.gids.terraria;
  };

  networking.firewall.allowedTCPPorts = [ 7777 ];

  systemd.sockets.terraria = {
    wantedBy = [ "sockets.target" ];
    socketConfig = {
      ListenFIFO = "/run/terraria.sock";
      SocketUser = "terraria";
      SocketMode = "0660";
      RemoveOnStop = true;
    };
  };

  systemd.services.terraria = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    bindsTo = [ "terraria.socket" ];

    preStop = ''
      printf '\nexit\n' > /run/terraria.sock
    '';

    serviceConfig = {
      User = "terraria";
      ExecStart = "${terraria-server}/bin/TerrariaServer -config ${serverConfig}";

      StateDirectory = "terraria";
      StateDirectoryMode = "0750";

      StandardInput = "socket";
      StandardOutput = "journal";
      StandardError = "journal";

      # SIGCONT is a noop — lets preStop finish before systemd gives up
      KillSignal = "SIGCONT";
      TimeoutStopSec = "120";
    };
  };
}