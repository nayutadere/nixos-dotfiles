{ config, pkgs, inputs, ...}:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    hypr = "hypr";
    nvim = "nvim";
    waybar = "waybar";
    foot = "foot";
    mango = "mango";
  };
in

{
	home.username = "nayuta";
	home.homeDirectory = "/home/nayuta";

    programs.git = {
        enable = true;
        extraConfig = {
            safe.directory = "~/nixos-dotfiles/";
        };
    };

	home.stateVersion = "25.05";
	programs.bash = {
		enable = true;
		shellAliases = {
		  editos = "vim ~/nixos-dotfiles/";
    };
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
    pavucontrol
    btop
    rmpc
    ani-cli
    mpv
    wine
    winetricks
    yt-dlp
    jdk
    unzip
    gale
  ];
}
