{ config, pkgs, lib, ... }:
let
in
{
  imports = [
    ./secrets
    ./programs.nix
    ./xsession.nix
    ./services.nix
    ./pkgs.nix
    ./stuff.nix
  ];
}
