{lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xclip
    xorg.xkbcomp
    xorg.xmodmap
    p7zip
    git
    glxinfo
    sxiv
    vim
    wineWowPackages.staging
    neofetch
    w3m
    gnumake
    pciutils
    jdk
    ntfs3g
    python3
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
  programs = {
    steam.enable = true;
    gnupg = {
      agent = {
        enableSSHSupport = true;
        enable = true;
        pinentryFlavor = "curses";
      };
    };
    fish.enable = true;
    dconf.enable = true;
  };
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command ca-references flakes
    '';
  };
}
