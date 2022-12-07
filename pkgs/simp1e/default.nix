{ lib, stdenvNoCC, fetchFromGitLab, python3, librsvg, xcursorgen }:

stdenvNoCC.mkDerivation rec {
  pname = "simp1e-cursors";
  version = "20221103.2";

  src = fetchFromGitLab {
    owner = "cursors";
    repo = "simp1e";
    rev = version;
    sha256 = "sha256-3DCF6TwxWwYK5pF2Ykr3OwF76H7J03vLNZch/XoZZZk=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    (python3.withPackages (ps: with ps; [ pillow ]))
    librsvg
    xcursorgen
  ];

  buildPhase = ''
    patchShebangs .
    HOME=$TMP ./build.sh
  '';

  installPhase = ''
    install -dm 755 $out/share/icons
    cp -dr --no-preserve='ownership' built_themes/* $out/share/icons/
  '';

  meta = with lib; {
    description = "An aesthetic cursor theme for Linux desktops";
    homepage = "https://gitlab.com/cursors/simp1e";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ natto1784 ];
  };
}

