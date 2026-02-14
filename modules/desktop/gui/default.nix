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
    rmpc # music1
    ani-cli # anime
    gimp3
    (lutris.override { extraPkgs = pkgs: [ winetricks ]; })
    trilium-desktop
    vscodium
    neovim
    aria2 # cli download manager
    obs-studio
    krita
    kdePackages.kdenlive
  ];
}
