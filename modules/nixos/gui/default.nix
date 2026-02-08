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
    discord
    #(discord.override {
    #  withVencord = true;
    #})
    mpv # video player
    rmpc # music
    ani-cli # anime
    gimp3
    (bottles.override {removeWarningPopup = true;})
    obsidian
    vscodium
    neovim
    aria2 # cli download manager
    obs-studio
    krita
    kdePackages.kdenlive
  ];
}
