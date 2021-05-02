{lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xclip
    xorg.xkbcomp
    xorg.xmodmap
    ffmpeg
    p7zip
    git
    glxinfo
    sxiv
    jq
    mono
    vim
    wineWowPackages.staging
    neofetch
    w3m
    gnumake
    pciutils
    jdk
    ntfs3g
    python38
    htop
    nodejs
    wget
    ripgrep
    patchelf
    feh
    dwm
    dmenu
    st
    kbd
  ];
  programs.steam.enable = true;
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
