{ config, pkgs, lib, ... }:
{
  home = {
    homeDirectory = "/home/natto";
    username = "natto";
    stateVersion = "22.11";
  };

  imports = [
    ./email.nix
    ./secrets
    ./programs.nix
    ./xsession.nix
    ./wayland.nix
    ./services.nix
    ./pkgs.nix
    ./stuff.nix
    ./emacs.nix
  ];
}
