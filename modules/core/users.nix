{ config, lib, pkgs, ... }:
{
  users.users.nayuta = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIODzs1Tt3FM4idtNhXmCgun/gMnFlIMONevsUJYhV6f8 shorekeeper"
    ];
  };

  security.sudo.wheelNeedsPassword = true;
}
