{lib, config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    p7zip
    git
    gnumake
    neofetch
    kbd
    htop
    vim
    wget
  ];
  programs = {
    zsh = {
      enable = true;
      promptInit = "PROMPT='%F{cyan}%~ %F{blue}>%f '\nRPROMPT='%F{cyan}%n%f@%F{red}%m'";
      histSize = 12000;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestions. enable = true;
      ohMyZsh.enable = true;
    };
    gnupg = {
      agent = {
        enable = true;
      };
    };
  };
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command ca-references flakes
    '';
    trustedUsers = [ "root" "ottan" ];
  };
}
