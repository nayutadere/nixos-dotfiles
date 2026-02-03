{ pkgs
, inputs
, ...
}:
{
  environment.systemPackages = with pkgs; [
    vivaldi
    bitwarden-desktop
    qimgv
    thud
    xarchiver
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    mpv # video player
    rmpc # music
    ani-cli # anime
    gimp3
    (lutris.override { extraPkgs = pkgs: [ winetricks ]; })
    obsidian
    vscodium
    neovim
    aria2 # cli download manager
    obs-studio
  ];
}
