{ lib, config, ...}:

{
  imports =
    [
      ./Satori/hardware.nix
      ./Satori/stuff.nix
      ./Satori/pkgs.nix
      ./Satori/networking.nix
      ./Satori/boot.nix
#      ./modules/nvidia-offload.nix
      ./modules/pipewire.nix
      ./modules/xorg.nix
    ];
  system.stateVersion = "20.09";
}
