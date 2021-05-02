{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gruvbox-icons";
  src = fetchgit {
    url = "https://github.com/sainnhe/gruvbox-material-gtk";
    rev = "2418ff7988411c57f8974f14adeb70a64e7f25c1";
    sha256 = "sha256-56Mu8zHcnB4++QXjAq3S7/UPvDB8DlpT14mAW3ketSY=";
  };
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share
    cp -r icons $out/share
  '';
}

