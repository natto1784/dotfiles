{lib, config, ...}:
{
  imports = 
  [
    ./networking.nix
    ./hardware.nix
    ./boot.nix
    ./services.nix
    ./mailserver.nix
  ];

  system.stateVersion = "21.11";
}
