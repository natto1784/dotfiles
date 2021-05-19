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
      ./modules/nvidia-offload.nix
      ./modules/pipewire.nix
      ./modules/xorg.nix
    ];
  system.stateVersion = "20.09";
}
