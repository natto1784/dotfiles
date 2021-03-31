{lib,stdenv,fetchFromGitHub}:
stdenv.mkDerivation rec{
  name = "customscripts";
  src = ./scripts;
  unpackPhase = ":";
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin
    for x in $out/bin/*;do chmod +x "$x";done
'';
 # src = fetchFromGitHub {
 #   owner = "idcretard";
 #   repo = "custom-scripts";
 #   rev = "86eaba74a01c8bafd8c81885eddbe9cd6f381e64";
 #   sha256 = "1g1z3mlp7h2ig1rmgabsbhcdnpgy65yki0dj3pr100jw202i6jqq";
 # };
}
