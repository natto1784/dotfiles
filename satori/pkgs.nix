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
    cachix
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
    zsh = {
      enable = true;
      promptInit = "PROMPT='%F{cyan}%~ %F{blue}>%f '\nRPROMPT='%F{cyan}%n%f@%F{red}%m'";
      histSize = 12000;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestions. enable = true;
      ohMyZsh.enable = true;
    };
    dconf.enable = true;
    adb.enable = true;
  };
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command ca-references flakes
    '';
    trustedUsers = [ "root" "natto" ];
  };
}
