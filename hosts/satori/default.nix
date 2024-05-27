{ lib, config, ... }:
{
  imports =
    [
      ./hardware.nix
      ./stuff.nix
      ./networking.nix
      ./boot.nix
      ./services.nix
      ./graphics.nix
    ];
  system.stateVersion = "23.05";
}
