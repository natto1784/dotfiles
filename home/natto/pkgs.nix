{ config, pkgs, ... }:
{
  home.packages = with pkgs; [

    # A/V, codec and media stuff
    ffmpeg-full
    sox
    pamixer
    mpdas
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

    # Wine and games and stuff
    wineWowPackages.stable
    master.winetricks
    games.wine-discord-ipc-bridge
    (games.osu-stable.overrideAttrs (_: {
      tricks = [ "gdiplus" "dotnet48" "meiryo" ];
    }))
    tlauncher
    lutris
    citra

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
