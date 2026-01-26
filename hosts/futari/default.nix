<<<<<<< HEAD
# host config for "futari" (T420 thinkpad)
=======
# host config for "klee" (T420 thinkpad)
>>>>>>> refs/remotes/origin/main

{ config, lib, pkgs, ...}:

{
    imports = [
    ./hardware-configuration.nix

    #
    ../../modules/nixos/mangowc
    ../../modules/nixos/common
<<<<<<< HEAD
    ../../modules/nixos/fonts
=======
    #../../modules/nixos/fonts
>>>>>>> refs/remotes/origin/main
    ../../modules/nixos/networking
    ];

    networking.hostName = "futari";
}
