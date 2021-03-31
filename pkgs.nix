{lib, config, pkgs, ... }:

{
  imports = [
    ./Packages/override.nix
  ];
  environment.systemPackages = with pkgs; [
    xclip
    dunst
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
    wineWowPackages.stable
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
  ];
}
