{ config, pkgs, ... }:
{
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "wheel" ];
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
    postgresql #for the client cli
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
      builders-use-substitutes = true
    '';
    settings.trusted-users = [ "root" ];
    buildMachines = [{
      hostName = "satori";
      systems = [ "x86_64-linux" "aarch64-linux" ];
      maxJobs = 4;
      speedFactor = 2;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    }];
    distributedBuilds = true;
  };
}
