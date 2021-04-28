{lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (callPackage ./customscripts.nix {})
    (callPackage ./mpd_discord_richpresence.nix {})
  ];
}
