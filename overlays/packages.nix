final: prev: {
  mpd_discord_richpresence = prev.callPackage ./mpd-rpc {};
  customscripts = prev.callPackage ./customscripts {};
  gruvbox-icons = prev.callPackage ./gruvbox-icons {};
  anup = prev.callPackage ./anup {};
}
