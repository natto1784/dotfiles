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
    (inputs.nbfc.packages.${pkgs.system}.nbfc-client-c)
    (flake.packages.${pkgs.system}.customscripts)
    translate-shell
    powertop
    cachix
    undervolt
    w3m

    # GUI utils
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
    iwgtk

    # Wine and games and stuff
    steam
    winetricks
    lutris
    flake.packages.${pkgs.system}.tlauncher
    mangohud
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable

    # Programming and dev stuff
    rust-analyzer
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
    anki-bin
    tor-browser-bundle-bin
    mailcap
    libsForQt5.qtstyleplugins
  ];
}
