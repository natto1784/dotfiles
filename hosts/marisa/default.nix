{config, pkgs, ...}:
{
  imports = 
  [
    ./networking.nix
    ./hardware.nix
    ./boot.nix
    ./services.nix
  ];
  system.stateVersion = "21.05";
}
