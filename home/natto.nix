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
 /*     fish_variables = {
        file = ./secrets/fish_variables.age;
        path = "${home}/.config/fish/fish_variables";
        mode = "660";
        };
*/
      mpdasrc = {
        file = ./secrets/mpdasrc.age;
        path = "${home}/.config/mpdasrc";
      };
      zshrc = {
        file = ./secrets/.zshrc.age;
        path = "${home}/.zshrc";
        mode = "660";
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
      hexchat
      luajit
      mpv
      jmtpfs
      dunst 
      flameshot
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
