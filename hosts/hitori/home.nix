{ config, pkgs, inputs, ...}:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    waybar = "waybar";
    foot = "foot";
    mango = "mango";
  };
in

{
	home.username = "nayuta";
	home.homeDirectory = "/home/nayuta";
	programs.git.enable = true;
	home.stateVersion = "25.05";
	programs.bash = {
		enable = true;
		shellAliases = {
		  editos = "nvim ~/nixos-dotfiles/";
    };
<<<<<<< Updated upstream
#    profileExtra = ''
 #     if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  #      exec uwsm start -S hyprland-uwsm.desktop
   #   fi
   # '';
=======
>>>>>>> Stashed changes
  };

  services.dunst.enable = true;

  services.mpd = {
    enable = true;
    musicDirectory = "~/kani/Music";
    # Optional:
    network.listenAddress = "any"; # if you want to allow non-localhost connections
    network.startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
    
    extraConfig = ''
      audio_output {
      type "pipewire"
      name "music output"
      mixer_type "software"
      }
    '';
    };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  })
  configs;

  services.mako.enable = true;

	home.packages = with pkgs; [
    neovim
    neofetch
    ripgrep
	  nil
	  nixpkgs-fmt
    nodejs
    gcc
    (discord.override {
    withOpenASAR = true;
    withVencord = true;
    })
    wofi #app launcher
    vivaldi 
    mangohud #gaming 
    prismlauncher #minecraft launcher
    easyeffects
    pavucontrol
    qpwgraph
    btop
    rmpc
    ani-cli
    mpv
    inputs.nix-citizen.packages.${system}.rsi-launcher
    obs-studio
    thunderbird
    wine
    winetricks
    yt-dlp
    jdk
    unzip
    gale
    vscodium
    aria2
  ];
}
