{lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mpd_discord_richpresence
    customscripts
    xclip
    dunst
    xorg.xkbcomp
    glibc
    proxychains
    #qt5.qmake
    xorg.xmodmap
    ffmpeg
    p7zip
    git
    glxinfo
    sox
    libmpdclient
    lxappearance
    jq
    mono
    vim
    mpd
    wineWowPackages.staging
    neofetch
    tor-browser-bundle-bin
    w3m
    gnumake
    pciutils
    jdk
    gcc
    ntfs3g
    python38
    luajit
    neovim
    htop
    nodejs
    wget
    ripgrep
    patchelf
    doas
    feh
    sxiv
    mpv
    dwm
    dmenu
    st
    kbd
    picom
    ncmpcpp
  ];
  programs.steam.enable = true;
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
