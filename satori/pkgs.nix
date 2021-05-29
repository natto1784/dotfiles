{lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bc
    gnumake
    pciutils
    git
    ntfs3g
    python3
    htop
    nodejs
    wineWowPackages.staging
    wget
    ripgrep
    kbd
    cachix
    gcc
    rustc
    jdk
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
      promptInit = "PROMPT='%B%F{cyan}%~ %F{blue}〉%f%b'\nRPROMPT='%B%F{cyan}%n%f@%F{red}%m%b'";
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
