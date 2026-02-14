{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    vivaldi
    bitwarden-desktop
    qimgv
    thud
    xarchiver
    discord
    mpv # video player
    rmpc # music
    ani-cli # anime
    gimp3
    (lutris.override { extraPkgs = pkgs: [ winetricks ]; })
    trilium
    vscodium
    neovim
    aria2 # cli download manager
    obs-studio
    krita
    kdePackages.kdenlive
  ];
}
