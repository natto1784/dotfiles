{ config, flake, inputs, pkgs, ... }:
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
    (dmenu.override { patches = [ ./patches/dmenu.patch ]; })
    (st.override {
      patches = [ ./patches/st.patch ];
      extraLibs = [ harfbuzz ];
    })
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
    (inputs.nbfc.packages.${pkgs.system}.nbfc-client-c)
    (flake.packages.${pkgs.system}.customscripts)

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
    (discord.override {
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
    winetricks
    citra
    yuzu
    ryujinx
    (inputs.nix-gaming.packages.${pkgs.system}.osu-stable)
    (flake.packages.${pkgs.system}.tlauncher)

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

    # Misc
    anki-bin
    tor-browser-bundle-bin
    mailcap
    (ncmpcpp.override {
      visualizerSupport = true;
      clockSupport = true;
    })
    libsForQt5.qtstyleplugins
  ];
}
