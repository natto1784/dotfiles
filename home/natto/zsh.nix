{ config, lib, ... }:
let
  secretPath = "${config.home.homeDirectory}/.zshenv_secret";
in
{
  programs.zsh.initExtra = lib.mkForce ''
    . ${secretPath};
    unsetopt extendedGlob
  '';

  age.secrets.zshenv_secret = {
    file = ./secrets/zshenv_secret;
    path = secretPath;
    mode = "660";
  };
}
