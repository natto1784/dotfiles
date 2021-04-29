{lib,stdenv,fetchFromGitHub}:
stdenv.mkDerivation rec{
  name = "customscripts";
  src = fetchFromGitHub {
    owner = "idcretard";
    repo = "custom-scripts";
    rev = "a996a52831316cc2c282904352654bd20c82f7bd";
    sha256 = "sha256-nw21YmcmQMF8NADnuHOc7eF2Yaj/r/1mYBn77fYK7s8=";
  };
  unpackPhase = ":";
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin
    for x in $out/bin/*;do chmod +x "$x";done
'';
}
