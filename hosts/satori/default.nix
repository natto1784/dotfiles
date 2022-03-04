{ lib, config, ...}:
{
  imports =
    [
      ./hardware.nix
      ./stuff.nix
      ./pkgs.nix
      ./networking.nix
      ./boot.nix
      ./services.nix
      ./nix.nix
    ];
  system.stateVersion = "21.05";
}
