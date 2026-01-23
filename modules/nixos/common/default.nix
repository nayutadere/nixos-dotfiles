# Common NixOS configuration shared across all hosts
{ config, lib, pkgs, ... }:

{
  nix.settings = {
        substituters = ["https://nix-citizen.cachix.org" "https://ezkea.cachix.org"];
        trusted-public-keys = ["nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo=" "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
        
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

 # services.syncthing = {
 # dataDir = "/home/nayuta";
 # user = "nayuta";
 # enable = true;
 # openDefaultPorts = true;
 # };

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  users.users.nayuta = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [
    "nvidia" ];
  hardware.nvidia.open = true;

  programs.steam.enable = true;

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11"; 

}

