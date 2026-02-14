# Audio configuration module
{ config, lib, pkgs, ... }:

{
  # enable sound with pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true; # prevent audio crackling

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol # volume control gui
    easyeffects
    qpwgraph
  ];
}
