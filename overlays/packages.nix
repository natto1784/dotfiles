final: prev:
let
  call = prev.callPackage; in
{
  customscripts = call ./customscripts { };
  mymacs = call ./emacs { };
  tlauncher = call ./tlauncher { };
  simp1e-cursors = call ./simp1e { };
}
