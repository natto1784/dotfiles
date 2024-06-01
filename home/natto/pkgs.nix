{ flake, pkgs, config, ... }:
{
  home.packages = with pkgs; [
    # A/V, codec and media stuff
    ffmpeg-full
    wireplumber
    pulseaudio
    pavucontrol
    spotify
    imagemagick

    # Utils
    neofetch
    rage
    curl
    yt-dlp
    p7zip
    unrar
    vim
    (flake.packages.${system}.customscripts)
    cachix
    steam-run

    # GUI utils
    slack
    webcord
    (xfce.thunar.override {
      thunarPlugins = with xfce; [
        thunar-media-tags-plugin
        thunar-volman
        thunar-archive-plugin
      ];
    })
    xfce.xfconf
    xfce.tumbler
    qbittorrent
    hexchat
    dunst
    gnome.zenity

    # Programming and dev stuff
    (texlive.combine {
      inherit (texlive)
        scheme-small
        babel
        lm
        graphics-def
        url
        mhchem
        wrapfig
        capt-of
        minted
        fvextra
        xstring
        catchfile
        framed
        upquote
        pdfsync
        tocloft
        enumitem
        multirow
        tcolorbox;
    })
    python3Packages.pygments

    # Misc
    anki
    tor-browser-bundle-bin
    mailcap
    libsForQt5.qtstyleplugins
  ] ++ lib.optionals config.isLaptop [
    powertop
    undervolt
  ];
}
