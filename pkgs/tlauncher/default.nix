{ pkgs ? import <nixpkgs> { } }:
let
  version = "2.885";
  jar = pkgs.stdenv.mkDerivation {
    pname = "tlauncher-jar";
    inherit version;
    src = pkgs.fetchzip {
      name = "tlauncher.zip";
      url = "https://dl2.tlauncher.org/f.php?f=files%2FTLauncher-${version}.zip";
      sha256 = "sha256-Erpctwdefb+pTKb5UHkEirAQyVmnPFWjS3345hTllOE=";
      stripRoot = false;
    };
    installPhase = ''
      cp $src/*.jar $out
    '';
  };
  fhs = pkgs.buildFHSUserEnv {
    name = "tlauncher";
    runScript = ''
      ${pkgs.openjdk8}/bin/java -jar "${jar}" "$@"
    '';
    targetPkgs = pkgs: with pkgs; [
      openal
      pulseaudio
      libpulseaudio
      zip
      zlib
      alsa-lib
      cpio
      cups
      file
      fontconfig
      freetype
      giflib
      glib
      gnome2.GConf
      gnome2.gnome_vfs
      gtk2
      libjpeg
      libGL
      openjdk8-bootstrap
      perl
      which
    ] ++
    (with xorg; [
      libICE
      libX11
      libXcursor
      libXext
      libXi
      libXinerama
      libXrandr
      xrandr
      libXrender
      libXt
      libXtst
      libXtst
      libXxf86vm
    ]);
  };
in
pkgs.stdenv.mkDerivation rec {
  pname = "tlauncher";
  inherit version;
  dontUnpack = true;
  installPhase = ''
    mkdir $out/{bin,share/applications} -p
    install ${fhs}/bin/tlauncher $out/bin
  '';
}
