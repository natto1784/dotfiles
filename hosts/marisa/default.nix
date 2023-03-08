{ config, pkgs, network, ... }:
{
  imports = [
    ./networking.nix
    ./hardware.nix
    ./boot.nix
    ./services.nix
  ];

  users.users.spark = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/spark";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = network.commonSSHKeys;
  };

  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "21.05";
}
