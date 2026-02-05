{
  config,
  pkgs,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    waybar = "waybar";
    foot = "foot";
    hypr = "hypr";
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
  home.username = "nayuta";
  home.homeDirectory = "/home/nayuta";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      editos = "nvim ~/nixos-dotfiles/";
    };
  };
  
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
  }) configs;

  services.mako.enable = true;
}
