{ config, pkgs, ... }:
{
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    git
    htop
    vim
    tmux
    wireguard-tools
    rnix-lsp
    nmap
    gcc
  ];

  programs = {
    gnupg = {
      agent = {
        enable = true;
        pinentryFlavor = "curses";
      };
    };
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.trusted-users = [ "root" "spark" ];
  };
}
