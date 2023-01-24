{ config, pkgs, lib, ... }:
{
  home = {
    homeDirectory = "/home/natto";
    username = "natto";
    stateVersion = "22.11";
  };

  imports = [
    ./email.nix
    ./programs.nix
    ./xsession.nix
    ./wayland.nix
    ./pkgs.nix
    ./stuff.nix
    ./emacs.nix
    ./dunst.nix
    ./git.nix
    ./mpd.nix
    ./zsh.nix
  ];
}
