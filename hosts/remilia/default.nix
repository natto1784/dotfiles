{ config, pkgs, ... }:
{
  imports = [
    ./networking.nix
    ./hardware.nix
    ./boot.nix
    ./services.nix
    ./mailserver.nix
  ];

  time.timeZone = "Asia/Kolkata";

  users.users.bat = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/bat";
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "21.11";
}
