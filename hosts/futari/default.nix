# host config for "futari" (T420 thinkpad)

{ config, lib, pkgs, ...}:

{
    imports = [
    ./hardware-configuration.nix

    # ../../modules/nixos/mangowc  # module does not exist yet
    ../../modules/nixos/common
    ../../modules/nixos/fonts
    ../../modules/nixos/networking
    ];

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "futari";

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "25.11";
}
