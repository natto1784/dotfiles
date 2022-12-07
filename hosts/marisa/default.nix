{ config, pkgs, ... }:
{
  imports =
    [
      ./networking.nix
      ./hardware.nix
      ./boot.nix
      ./services.nix
      ./stuff.nix
    ];
  system.stateVersion = "21.05";
}
