{ lib, config, ... }:
{
  imports =
    [
      ./hardware.nix
      ./stuff.nix
      ./pkgs.nix
      ./networking.nix
      ./boot.nix
      ./services.nix
      ./graphics.nix
      ./xorg.nix
      ./wayland.nix
      ./nix.nix
    ];
  system.stateVersion = "21.05";
}
