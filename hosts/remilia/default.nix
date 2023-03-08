{ config, ... }:
{
  imports =
    [
      ./networking.nix
      ./hardware.nix
      ./boot.nix
      ./services.nix
      ./mailserver.nix
    ];

  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "21.11";
}
