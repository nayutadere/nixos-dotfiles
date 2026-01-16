{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  nix.settings = {
        substituters = ["https://nix-citizen.cachix.org" "https://ezkea.cachix.org"];
        trusted-public-keys = ["nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo=" "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
        
    };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.getty.autologinUser = "nayuta";

  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "opportunistic";
  };

  #networking.hostName = "nixos-flandre"; # Define your hostname.
  networking = {
    hostName = "nixos-flandre";
    
    nameservers = [ "9.9.9.9" "149.112.112.112"];

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

 # services.syncthing = {
 # dataDir = "/home/nayuta";
 # user = "nayuta";
 # enable = true;
 # openDefaultPorts = true;
 # };

  fileSystems."/mnt/games" = {
    device = "dev/disk/by-uuid/9f50cec9-83f1-48b2-b03b-d42a21f53cdc";
    fsType = "ext4";
  };

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
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  programs.yazi.enable = true;

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    
  };

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

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
    nerd-fonts.mononoki
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11"; 

}

