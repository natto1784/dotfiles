{ config, pkgs, ... }:
let
  home = config.home.homeDirectory;
in
{
  services = {
    baremacs = {
      enable = true;
      package = pkgs.mymacs ./config/emacs/config.org;
      defaultEditor = {
        enable = false;
        editor = "emacsclient";
      };
      copyConfigFiles = {
        enable = true;
        files = {
          "config.org" = ./config/emacs/config.org;
          "init.el" = ./config/emacs/init.el;
        };
      };
    };

    sxhkd = {
      enable = false;
      extraConfig = builtins.readFile ./config/sxhkd/sxhkdrc;
    };

    mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
      dbFile = "${config.home.homeDirectory}/.config/mpd/database";
      dataDir = "${config.home.homeDirectory}/.config/mpd";
      network = {
        startWhenNeeded = true;
        listenAddress = "any";
        port = 6600;
      };
      extraConfig = builtins.readFile ./config/mpd/mpd.conf;
    };
    mpd-discord-rpc.enable = true;
  };
}
