# core (includes settings all systems require ig)
{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    auto-optimise-store = true;

    substituters = [
      "https://nix-citizen.cachix.org"
      "https://ezkea.cachix.org"
    ];
    trusted-public-keys = [
      "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Lisbon";

  environment.systemPackages = with pkgs; [
    tree
    vim
    wget
    git
    htop
    tmux
    ripgrep
    btop
    fastfetch
    unzip
    tldr
    yt-dlp
    nixfmt
  ];

  security.polkit.enable = true;
}
