{ config, ... }:
{
  imports = [
    ./networking.nix
    ./hardware.nix
    ./boot.nix
    ./services.nix
  ];

  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "21.05";
}
