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
    ];
  system.stateVersion = "21.05";
}
