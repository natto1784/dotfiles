{ lib, config, ...}:
{
  imports =
    [
      ./satori/hardware.nix
      ./satori/stuff.nix
      ./satori/pkgs.nix
      ./satori/networking.nix
      ./satori/boot.nix
      ./satori/services.nix
      ./common/nvidia-offload.nix
      ./common/pipewire.nix
      ./common/xorg.nix
      ../../configs/nvim.nix
    ];
  system.stateVersion = "20.09";
}
