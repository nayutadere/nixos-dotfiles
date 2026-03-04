# core (includes settings all systems require ig)
{ config, lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Lisbon";

  environment.systemPackages = with pkgs; [
    tree
    vim
    wget
    git
    htop
    btop
    tmux
    ripgrep
    fastfetch
    unzip
    tldr
    yt-dlp
    nixfmt
  ];

  security.polkit.enable = true;
}
