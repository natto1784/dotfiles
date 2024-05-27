{ config, pkgs, conf, ... }:
{
  imports = [
    ./networking.nix
    ./hardware.nix
    ./boot.nix
    ./services
  ];

  users.users.spark = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/spark";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = conf.network.commonSSHKeys;
  };
  programs.zsh.enable = true;

  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "21.05";

  security.pki.certificateFiles = [ ../../cert.pem ../../consul-agent-ca.pem ];
}
