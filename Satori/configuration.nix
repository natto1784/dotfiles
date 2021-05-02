{ lib, config, ...}:

{
  imports =
    [
      ./hardware.nix
      ./stuff.nix
      ./pkgs.nix
      ./networking.nix
      ./boot.nix
    ];
  system.stateVersion = "20.09";
}
