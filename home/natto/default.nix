{ config, pkgs, lib, ... }:
let
in
{
  imports = [
    ./email.nix
    ./secrets
    ./programs.nix
    ./xsession.nix
    ./wayland.nix
    ./services.nix
    ./pkgs.nix
    ./stuff.nix
  ];
}
