{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.git.override {
      doInstallCheck = false;
      sendEmailSupport = true;
      withManual = false;
    };
  };

  age.secrets.gitconfig = {
    file = ./secrets/gitconfig.age;
    path = "${config.home.homeDirectory}/.gitconfig";
    symlink = false;
  };
}
