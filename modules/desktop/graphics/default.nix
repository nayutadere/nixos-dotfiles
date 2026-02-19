{ config, ... }:

{
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [
    "nvidia"
  ];

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  hardware.nvidia.open = true;
}
