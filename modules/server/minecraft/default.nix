# Minecraft server module - ATM10
{ config, lib, pkgs, ... }:

{
  systemd.services.atm10 = {
    description = "All The Mods 10 Server";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      Type = "simple";
      WorkingDirectory = "/opt/atm10";
      ExecStart = "${pkgs.jdk21}/bin/java @user_jvm_args.txt @libraries/net/neoforged/neoforge/21.1.215/unix_args.txt nogui";
      Restart = "on-failure";
      RestartSec = "10s";
      User = "minecraft";
      Group = "minecraft";
    };
  };

  users.users.minecraft = {
    isSystemUser = true;
    group = "minecraft";
    home = "/opt/atm10";
  };

  users.groups.minecraft = { };
}
