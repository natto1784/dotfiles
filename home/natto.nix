{ config, pkgs, lib, ... }:
let
  home = config.home.homeDirectory;
in
{
  imports = [
    ./stuff/programs.nix 
    ./stuff/xsession.nix
    ./stuff/secret.nix
    ./stuff/services.nix
    ./stuff/gtk.nix
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  age = {
    sshKeyPaths = [ "${home}/.ssh/id_ed25519" ];
    secrets = {
      fish_variables = {
        file = ./secrets/fish_variables.age;
        path = "${home}/.config/fish/fish_variables";
      };
      mpdasrc = {
        file = ./secrets/mpdasrc.age;
        path = "${home}/.config/mpdasrc";
      };
    };
  };
  home = {
    packages = with pkgs; [
      ffmpeg
      sox
      rage
      curl
      pamixer
      mpdas
      dunst
      pavucontrol
      anup
      proxychains
      cmake
      xfce.thunar
      xfce.xfconf
      xfce.tumbler
      discord
      customscripts
      mpd_discord_richpresence
      sox
      qbittorrent
      tor-browser-bundle-bin
      mpc_cli
      flameshot
      hexchat
      luajit
      mpv
      jmtpfs
      youtube-dl
    ];

    file = {
      dwm-autostart = {
        source = ./config/dwm/autostart.sh;
        target = "${home}/.dwm/autostart.sh";
      };
      dwm-status = {
        source = ./config/dwm/bruhstatus.sh;
        target = "${home}/.dwm/bruhstatus.sh";
      };
    };
  };
}
