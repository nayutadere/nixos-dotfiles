{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.getty.autologinUser = "nayuta";

  #networking.hostName = "nixos-flandre"; # Define your hostname.
  networking = {
    hostName = "nixos-flandre";

    interfaces = {
      enp11s0 = {
        wakeOnLan.enable = true;
      };
    };
    firewall = {
      allowedUDPPorts = [ 9 ];
      allowedTCPPorts = [ 8384 ];
    };
  };

  services.syncthing = {
  dataDir = "/home/nayuta/";
  user = "nayuta";
  enable = true;
  openDefaultPorts = true;
  };

  fileSystems."/mnt/games" = {
    device = "dev/disk/by-uuid/9f50cec9-83f1-48b2-b03b-d42a21f53cdc";
    fsType = "ext4";
  };

  #services.xserver.enable = true; # optional
  #services.displayManager.sddm.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  #services.desktopManager.plasma6.enable = true;

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
  programs.thunar.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  programs.yazi.enable = true;

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    foot
    waybar
    hyprpaper
    hyprshot
];

  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11"; 

}

