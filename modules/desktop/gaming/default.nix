{ pkgs, inputs, ... }:
{
  # game mode
  programs.gamemode.enable = true;

  # 32 bit libraries
  hardware.graphics.enable32Bit = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    protonplus # wine/proton compatibility tool with gui
    mangohud # performance tracker
    prismlauncher # minecraft launcher
    gale # mod manager
    inputs.nix-citizen.packages.${system}.rsi-launcher # star citizen
  ];
}
