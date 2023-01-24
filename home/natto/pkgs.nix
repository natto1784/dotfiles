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
    rage
    curl
    yt-dlp
    p7zip
    unrar
    vim
    jmtpfs
    neofetch
    (inputs.nbfc.packages.${pkgs.system}.nbfc-client-c)
    (flake.packages.${pkgs.system}.customscripts)
    translate-shell
    powertop
    cachix
    undervolt

    # GUI utils
    (discord.override {
      nss = nss_latest;
    })
    inputs.webcord.legacyPackages.${pkgs.system}.webcord
    qbittorrent
    hexchat
    luajit
    dunst
    feh
    authy
    gnome.zenity

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
    libsForQt5.qtstyleplugins
  ];
}
