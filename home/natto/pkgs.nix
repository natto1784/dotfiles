{ config, pkgs, ... }:
{
  home.packages = with pkgs; [

    # A/V, codec and media stuff
    ffmpeg-full
    sox
    pamixer mpdas
    mpv
    mpc_cli
    pulseaudio
    pavucontrol
    spotify
    noisetorch
    imagemagick
    (qjackctl.override { jackSession = true; })

    # Utils
    rage
    curl
    dmenu
    st
    yt-dlp
    xclip
    xorg.xkbcomp
    xorg.xmodmap
    p7zip
    unrar
    glxinfo
    sxiv
    vim
    jmtpfs
    neofetch
    xdotool
    nbfc-linux
    customscripts

    # GUI utils
    (xfce.thunar.override {
      thunarPlugins = with xfce; [
        thunar-media-tags-plugin
        thunar-volman
        thunar-archive-plugin
      ];
    })
    xfce.xfconf
    xfce.tumbler
    flameshot
    (master.discord.override {
      nss = nss_latest;
    })
    qbittorrent
    hexchat
    luajit
    dunst
    feh
    xmobar
    arc-theme
    arc-icon-theme
    authy
    calibre
    gnome.zenity
    stalonetray
    obs-studio

    # Wine and games and stuff
    wineWowPackages.stable
    master.winetricks
    tlauncher
    lutris
    citra
    (yuzu.overrideAttrs (_: rec {
      version = "1245";
      src = fetchFromGitHub {
        owner = "yuzu-emu";
        repo = "yuzu-mainline";
        rev = "mainline-0-${version}";
        sha256 = "sha256-lWXlY1KQC067MvCRUFhmr0c7KDrHDuwJOhIWMKw1f+A=";
        fetchSubmodules = true;
      };
    }))
    ryujinx

    # Dev shit
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
        tcolorbox;
    })
    python3Packages.pygments
    inform7
    gnome-inform7

    # Misc
    teams
    anki-bin
    tor-browser-bundle-bin
    mailcap
    (ncmpcpp.override {
      visualizerSupport = true;
      clockSupport = true;
    })
  ];
}
