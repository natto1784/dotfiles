{ config, pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  home = {
    packages = with pkgs; [
      discord
      customscripts
      mpd_discord_richpresence
      qbittorrent
    ];
  };
}
