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
    vesktop
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
    zenity

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
