{lib, config, ...}:
{
  imports = 
  [
    ./networking.nix
    ./hardware.nix
    ./boot.nix
    ./services.nix
    ./mailserver.nix
    ./stuff.nix
  ];

  system.stateVersion = "21.11";
}
