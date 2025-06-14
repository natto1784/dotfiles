{ config, lib, ... }:
let
  secretPath = "${config.home.homeDirectory}/.zshenv_secret";
in
{
  programs.zsh.initContent = lib.mkAfter ''
    . ${secretPath};
  '';

  age.secrets.zshenv_secret = {
    file = ./secrets/zshenv_secret;
    path = secretPath;
    symlink = false;
    mode = "660";
  };
}
