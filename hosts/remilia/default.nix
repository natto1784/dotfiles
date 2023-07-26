{ config, pkgs, lib', ... }:
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
    openssh.authorizedKeys.keys = lib'.network.commonSSHKeys;
  };
  programs.zsh.enable = true;

  system.stateVersion = "21.11";
}
