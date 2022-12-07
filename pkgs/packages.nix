final: prev:
let
  call = prev.callPackage;
in
{
  customscripts = call ./customscripts { };
  tlauncher = call ./tlauncher { };
  simp1e-cursors = call ./simp1e { };
}
