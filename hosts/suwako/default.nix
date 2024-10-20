{ config, pkgs, conf, ... }:
{
  imports = [
    ./networking.nix
    ./hardware.nix
    ./boot.nix
    ./services.nix
  ];

  time.timeZone = "Asia/Kolkata";

  users.users.kero = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/kero";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = conf.network.commonSSHKeys;
  };

  programs.zsh.enable = true;

  system.stateVersion = "24.05";
}
