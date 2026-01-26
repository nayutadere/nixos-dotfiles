# host config for "klee" (T420 thinkpad)

{ config, lib, pkgs, ...}:

{
    imports = [
    ./hardware-configuration.nix

    #
    ../../modules/nixos/mangowc
    ../../modules/nixos/common
    #../../modules/nixos/fonts
    ../../modules/nixos/networking
    ];

    networking.hostName = "futari";
}
