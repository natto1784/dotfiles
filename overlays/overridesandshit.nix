final: prev: {

  dmenu = prev.dmenu.overrideAttrs (oldAttrs: rec {
    src = builtins.fetchTarball {
      url = "https://dl.suckless.org/tools/dmenu-5.0.tar.gz";
      sha256 = "0gjjbh49j85rpbmiqj236g4c1zb1h8xh41mcjsvnzgwn72893mk6";
    };
    patches = [./suckless/dmenu.patch];
  });

  dwm = prev.dwm.overrideAttrs (oldAttrs: rec {
    src = builtins.fetchTarball {
      url = "https://dl.suckless.org/dwm/dwm-6.2.tar.gz";
      sha256 = "0qdh8amfkjpvbwffar0byybcqi5w7v1wdqb39h75521haa6mh8xg";
    };
    patches = [./suckless/dwm.patch];
  });

  st = prev.st.overrideAttrs (oldAttrs: rec {
    src = builtins.fetchTarball {
        url = "https://dl.suckless.org/st/st-0.8.4.tar.gz";
        sha256 = "01z6i60fmdi5h6g80rgvqr6d00jxszphrldx07w4v6nq8cq2r4nr";
      };
    patches = [./suckless/st.patch];
  });

  kbd = prev.kbd.overrideAttrs (oldAttrs: rec{
    buildInputs = oldAttrs.buildInputs ++ [ prev.gzip ];
    colemak-dh = prev.writeText "colemak-dh.map" (builtins.readFile ./colemak-dh.map);
    postInstall = "${oldAttrs.postInstall}\n cp ${colemak-dh} $out/share/keymaps/i386/colemak/colemak-dh.map\n gzip $out/share/keymaps/i386/colemak/colemak-dh.map";
  });

  ncmpcpp = prev.ncmpcpp.override {
    visualizerSupport = true;
    clockSupport = true;
  };

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
  discord = prev.discord.overrideAttrs (_ : { 
    src = builtins.fetchTarball { url = "https://discord.com/api/download/stable?platform=linux&format=tar.gz"; sha256="1ahj4bhdfd58jcqh54qcgafljqxl1747fqqwxhknqlasa83li75n";};
    });
}
