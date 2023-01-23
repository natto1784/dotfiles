{ config, flake, inputs, pkgs, ... }:
{
  home.packages = with pkgs; [

    # A/V, codec and media stuff
    ffmpeg-full
    pamixer
    mpdas
    mpv
    mpc_cli
    pulseaudio
    pavucontrol
    spotify
    imagemagick

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
    sxiv
    vim
    jmtpfs
    neofetch
    xdotool
    (inputs.nbfc.packages.${pkgs.system}.nbfc-client-c)
    (flake.packages.${pkgs.system}.customscripts)
    translate-shell
    powertop
    cachix
    undervolt

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
    gnome.zenity
    stalonetray

    # Wine and games and stuff
    steam
    wineWowPackages.stable
    winetricks
    #   (inputs.nix-gaming.packages.${pkgs.system}.osu-stable)
    (flake.packages.${pkgs.system}.tlauncher)
    mangohud

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
    (ncmpcpp.override {
      visualizerSupport = true;
      clockSupport = true;
    })
    libsForQt5.qtstyleplugins
  ];
}
