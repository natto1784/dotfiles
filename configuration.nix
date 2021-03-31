{lib, config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ./stuff.nix
      ./pkgs.nix
      ./networking.nix
    ];
  system.stateVersion = "20.09";
}
