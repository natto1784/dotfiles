{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    htop
    vim
    wireguard-tools
    rnix-lsp
    nmap
    gcc
    postgresql #for the client cli
  ];

  programs = {
    zsh = {
      enable = true;
      promptInit = "PROMPT='%B%F{cyan}%~ %F{blue}>%f%b '\nRPROMPT='%B%F{cyan}%n%f@%F{red}%m%b'";
      histSize = 12000;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestions = {
        enable = true;
        highlightStyle = "fg=yellow,bold";
      };
      ohMyZsh.enable = true;
    };
    gnupg = {
      agent = {
        enable = true;
        pinentryFlavor = "curses";
      };
    };
  };
}
