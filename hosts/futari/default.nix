# furati
{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # core
    ../../modules/core/base.nix
    ../../modules/core/users.nix

    # shared
    ../../modules/shared/networking.nix
    ../../modules/shared/security.nix
    ../../modules/shared/fonts

    # ../../modules/desktop/graphics
    # ../../modules/desktop/gui
  ];

  # Hostname
  networking.hostName = "futari";

  # Laptop-specific: TLP for battery management
  services.tlp.enable = true;

  # State version (don't change after initial install)
  system.stateVersion = "25.11";
}
