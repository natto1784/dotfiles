{lib, stdenv, fetchFromGitHub, discord-rpc, cmake, libmpdclient}:
with lib;
stdenv.mkDerivation rec{
  name = "mpd_discord_richpresence";
  src = fetchFromGitHub {
    owner = "justas-d";
    repo = "mpd-rich-presence-discord";
    rev = "ced628d3eaf3f18c5eff286b0955c605616348ee";
    sha256 = "0vl31sdgxalbnc4d4fggzqs2vsssibn53pjm6wj596cfkfpdf4y3";
  };
  buildInputs = [ 
    libmpdclient 
    cmake
    discord-rpc
  ];
  configurePhase = ''
    cmake .
    '';
  buildPhase = ''
    make
    '';
  installPhase = ''
    mkdir -p $out/bin
    cp mpd_discord_richpresence $out/bin/
    '';
}
