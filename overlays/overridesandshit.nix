final: prev: {

  dmenu = prev.dmenu.overrideAttrs (oldAttrs: rec {
    version = "5.2";
    src = builtins.fetchTarball {
      url = "https://dl.suckless.org/tools/dmenu-${version}.tar.gz";
      sha256 = "1rxxc3qdb5qvwg284f0hximg9953fnvlymxwmi1zlqkqbs8qbizk";
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
    version = "0.9";
    src = builtins.fetchTarball {
      url = "https://dl.suckless.org/st/st-${version}.tar.gz";
      sha256 = "1bdhh5lnhiz7q4ihig1f5q0ay5glsqxhpxpnsfqxwffqqwmy1vlh";
    };
    patches = [ ./patches/st.patch ];
  });

  proxychains = prev.proxychains.overrideAttrs (_: {
    postInstall = ":";
  });
}
