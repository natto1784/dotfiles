{ config, flake, inputs, pkgs, ... }:
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
    jmtpfs
    (flake.packages.${pkgs.system}.customscripts)
    translate-shell
    powertop
    cachix
    undervolt
    w3m
    steam-run

    # GUI utils
    slack
    (discord.override {
      nss = nss_latest;
    })
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
    luajit
    dunst
    authy
    gnome.zenity

    # Wine and games and stuff
    wineWowPackages.stable
    steam
    lutris
    winetricks
    flake.packages.${pkgs.system}.tlauncher
    mangohud
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin

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
    inform7
    ghc
    nodejs
    rust-bin.nightly.latest.default
    clang-tools
    openjdk

    # Misc
    anki
    tor-browser-bundle-bin
    mailcap
    libsForQt5.qtstyleplugins
  ];
}
