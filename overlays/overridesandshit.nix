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

  proxychains = prev.proxychains.overrideAttrs (_: {
    postInstall = ":";
  });
}
