{ config, pkgs, ... }:

{
  imports = [
    ./modules/programs.nix 
    ./modules/xsession.nix
    ./modules/files.nix
    ./modules/services.nix
    ./modules/gtk.nix
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  home = {
    packages = with pkgs; [
      mpdas
      mpd
      dunst
      pavucontrol
      anup
      proxychains
      cmake
      xfce.thunar
      discord
      customscripts
      mpd_discord_richpresence
      sox
      qbittorrent
      tor-browser-bundle-bin
      mpc_cli
      flameshot
      luajit
      mpv
    ];
  };
}
