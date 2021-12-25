final: prev: {

  dmenu = prev.dmenu.overrideAttrs (oldAttrs: rec {
    src = builtins.fetchTarball {
      url = "https://dl.suckless.org/tools/dmenu-5.0.tar.gz";
      sha256 = "0gjjbh49j85rpbmiqj236g4c1zb1h8xh41mcjsvnzgwn72893mk6";
    };
    patches = [ ./patches/dmenu.patch ];
  });

  dwm = prev.dwm.overrideAttrs (oldAttrs: rec {
    src = builtins.fetchTarball {
      url = "https://dl.suckless.org/dwm/dwm-6.2.tar.gz";
      sha256 = "0qdh8amfkjpvbwffar0byybcqi5w7v1wdqb39h75521haa6mh8xg";
    };
    patches = [ ./patches/dwm.patch ];
  });

  st = prev.st.overrideAttrs (oldAttrs: rec {
    src = builtins.fetchTarball {
      url = "https://dl.suckless.org/st/st-0.8.4.tar.gz";
      sha256 = "01z6i60fmdi5h6g80rgvqr6d00jxszphrldx07w4v6nq8cq2r4nr";
    };
    patches = [ ./patches/st.patch ];
  });

  ncmpcpp = prev.ncmpcpp.override {
    visualizerSupport = true;
    clockSupport = true;
  };

  picom = prev.picom.overrideAttrs (oldAttrs: rec{
    src = prev.fetchFromGitHub {
      owner = "jonaburg";
      repo = "picom";
      rev = "a8445684fe18946604848efb73ace9457b29bf80";
      sha256 = "sha256-R+YUGBrLst6CpUgG9VCwaZ+LiBSDWTp0TLt1Ou4xmpQ=";
      fetchSubmodules = true;
    };
  });

  proxychains = prev.proxychains.overrideAttrs (_: {
    postInstall = ":";
  });

  /* tor-browser-bundle-bin = prev.tor-browser-bundle-bin.overrideAttrs (_ : { 
    src = builtins.fetchurl { url = "https://www.torproject.org/dist/torbrowser/10.5.2/tor-browser-linux64-10.5.2_en-US.tar.xz"; sha256="16zk7d0sxm2j00vb002mjj38wxcxxlahnfdb9lmkmkfms9p9xfkb";};
    });*/

}
