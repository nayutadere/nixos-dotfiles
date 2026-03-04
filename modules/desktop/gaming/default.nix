{ pkgs, inputs, ... }:
{
  nix.settings = {
    substituters = [
      "https://nix-citizen.cachix.org"
      "https://ezkea.cachix.org"
    ];
    trusted-public-keys = [
      "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
  };
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
    steam-run
    openmw
    protonplus # wine/proton compatibility tool with gui
    mangohud # performance tracker
    prismlauncher # minecraft launcher
    gale # mod manager
    inputs.nix-citizen.packages.${system}.rsi-launcher # star citizen
  ];
}
