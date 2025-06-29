final: prev:
let
  call = prev.callPackage;
in
{
  customscripts = call ./customscripts { };
  simp1e-cursors = call ./simp1e { };
  nattovim = call ./nattovim { };
}
