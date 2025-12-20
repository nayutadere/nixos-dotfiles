{ config, pkgs, inputs, ...}:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    hypr = "hypr";
    nvim = "nvim";
    waybar = "waybar";
    alacritty = "alacritty";
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
			btw = "echo I use nixos, btw";
		  editos = "nvim ~/nixos-dotfiles/";
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
          exec uwsm start -S hyprland-uwsm.desktop
      fi
	  '';
  };

  services.dunst.enable = true;

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  })
  configs;

	home.packages = with pkgs; [
    neovim
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
    ani-cli
    mpv
    inputs.nix-citizen.packages.${system}.rsi-launcher
  ];
}
