final: prev: {

  dmenu = prev.dmenu.overrideAttrs (oldAttrs: rec {
    configFile = prev.writeText "config.def.h" (builtins.readFile ./dmenu/config.def.h);
    postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
  });

  ncmpcpp = prev.ncmpcpp.override {
    visualizerSupport = true;
    clockSupport = true;
  };

  dwm = prev.dwm.overrideAttrs (oldAttrs: rec {
    src = prev.fetchFromGitHub {
      owner = "natto1784";
      repo = "dwm";
      rev = "cd69bb00b0ecd941cdb5d048df029f3b762eea8c";
      sha256 = "sha256-dZyF7GnVJZzzAy8DO2pqCoIj7t1vZLdfhHm1cJKXah0=";
    };
  });

  st = prev.st.overrideAttrs (oldAttrs: rec {
    src = prev.fetchFromGitHub {
      owner = "natto1784";
      repo = "st";
      rev = "0cd1e394e6d07c5f605ae23070c40de9690bafb1";
      sha256 = "sha256-EY5Amz16Drc4i0uEAYTPEHcGex0s3pzHDqfDp4Z5OGY=";
    };
  });

  kbd = prev.kbd.overrideAttrs (oldAttrs: rec{
    buildInputs = oldAttrs.buildInputs ++ [ prev.gzip ];
    colemak-dh = prev.writeText "colemak-dh.map" (builtins.readFile ./colemak-dh.map);
    postInstall = "${oldAttrs.postInstall}\n cp ${colemak-dh} $out/share/keymaps/i386/colemak/colemak-dh.map\n gzip $out/share/keymaps/i386/colemak/colemak-dh.map";
  });

  picom = prev.picom.overrideAttrs (oldAttrs: rec{
    version = "Next";
    src = prev.fetchFromGitHub {
      owner = "yshui";
      repo = "picom";
      rev = "v${version}";
      sha256 = "0asp2hg1jx909kl7i876mcx00vwg9w2swr9i6d786iwgs247dc9i";
      fetchSubmodules = true;
    };
  });
}