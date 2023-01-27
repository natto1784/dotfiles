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
    ./eww
   # ./xsession.nix :(
    ./wayland.nix
    ./pkgs.nix
    ./stuff.nix
    ./emacs.nix
    ./gtk.nix
    ./dunst.nix
    ./git.nix
    ./mpd.nix
    ./zsh.nix
  ];
}
