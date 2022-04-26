final: prev: {

  dmenu = prev.dmenu.overrideAttrs (oldAttrs: rec {
    src = builtins.fetchTarball {
      url = "https://dl.suckless.org/tools/dmenu-5.1.tar.gz";
      sha256 = "1zwl0qlc4mmr973km03lmnfxjibdh2inwzb0vr6pvrfhrm0glvrk";
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
      url = "https://dl.suckless.org/st/st-0.8.5.tar.gz";
      sha256 = "0iy7sj40m5x7wr4qkicijckk3cb0h9815mzacfjb3xrlrvpx6hm5";
    };
    patches = [ ./patches/st.patch ];
  });

  ncmpcpp = prev.ncmpcpp.override {
    visualizerSupport = true;
    clockSupport = true;
  };

  /*picom = prev.picom.overrideAttrs (oldAttrs: rec{
    src = prev.fetchFromGitHub {
    owner = "jonaburg";
    repo = "picom";
    rev = "a8445684fe18946604848efb73ace9457b29bf80";
    sha256 = "sha256-R+YUGBrLst6CpUgG9VCwaZ+LiBSDWTp0TLt1Ou4xmpQ=";
    fetchSubmodules = true;
    };
    });*/

  proxychains = prev.proxychains.overrideAttrs (_: {
    postInstall = ":";
  });

  /* tor-browser-bundle-bin = prev.tor-browser-bundle-bin.overrideAttrs (_ : { 
    src = builtins.fetchurl { url = "https://www.torproject.org/dist/torbrowser/10.5.2/tor-browser-linux64-10.5.2_en-US.tar.xz"; sha256="16zk7d0sxm2j00vb002mjj38wxcxxlahnfdb9lmkmkfms9p9xfkb";};
    });*/

}
