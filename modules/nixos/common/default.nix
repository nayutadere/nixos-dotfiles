{ config, lib, pkgs, ... }:

{
  nix.settings = {
        substituters = ["https://nix-citizen.cachix.org" "https://ezkea.cachix.org"];
        trusted-public-keys = ["nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo=" "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
        
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "Europe/Lisbon";

  nix.settings.auto-optimise-store = true;

  nixpkgs.config.allowUnfree = true;

  # apps ask for permissions when requiring sudo priveliges
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    unzip
    yt-dlp
    git
    fastfetch
    ripgrep
    btop
    tmux
    tldr
    nixpkgs-fmt # nix formatter
  ];

  # allow app images
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # define user account
  users.users.nayuta = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

}

