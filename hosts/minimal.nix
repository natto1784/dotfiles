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
    nmap
    gcc
  ];

  programs = {
    gnupg = {
      agent = {
        enable = true;
      };
    };
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.trusted-users = [ "root" ];
  };
}
