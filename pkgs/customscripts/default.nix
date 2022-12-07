{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  name = "customscripts";
  src = ./src;
  unpackPhase = ":";
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin
    chmod -R +x $out/bin/*
  '';
}
