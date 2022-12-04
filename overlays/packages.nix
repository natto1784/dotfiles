final: prev:
let
  call = prev.callPackage; in
{
  mpd_discord_richpresence = call ./mpd-rpc { };
  customscripts = call ./customscripts { };
  gruvbox-icons = call ./gruvbox-icons { };
  mymacs = c: call ./emacs { conf = c; };
  tlauncher = call ./tlauncher { };
  simp1e-cursors = call ./simp1e { };
}
