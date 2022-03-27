{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    ffmpeg-full
    sox
    rage
    curl
    pamixer
    mpdas
    pavucontrol
    unstable.anup
    xfce.thunar
    xfce.xfconf
    xfce.tumbler
    master.discord
    mpd_discord_richpresence
    sox
    qbittorrent
    #tor-browser-bundle-bin
    mpc_cli
    hexchat
    luajit
    mpv
    jmtpfs
    dunst
    flameshot
    yt-dlp
    xclip
    xorg.xkbcomp
    xorg.xmodmap
    p7zip
    unrar
    glxinfo
    sxiv
    vim
    feh
    dmenu
    st
    neofetch
    xmobar
    xdotool
    arc-theme
    arc-icon-theme
    tor-browser-bundle-bin
    wineWowPackages.stable
    master.winetricks
    games.wine-discord-ipc-bridge
    (games.osu-stable.overrideAttrs (_: {
      tricks = [ "gdiplus" "dotnet48" "meiryo" ];
    }))
    pmidi
    #   dosbox
    authy
    unstable.premid
    (master.tauon.override { withDiscordRPC = true; })
    nbfc-linux
    pulseaudio
    (texlive.combine { inherit (texlive) scheme-small babel lm graphics-def url mhchem wrapfig capt-of; })
    #    carla
    #      electrum
    anki-bin
    spotify
    deluge
    teams
    #      libreoffice
    google-drive-ocamlfuse
    customscripts
    (qjackctl.override { jackSession = true; })
    stable.lmms
    #     stable.blender
    neomutt
    mailcap
    element-desktop
    syncplay
    betterdiscordctl
  ];
}
