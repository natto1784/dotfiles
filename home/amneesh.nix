{ config, pkgs, inputs, ... }:
{
  home = {
    homeDirectory = "/home/amneesh";
    username = "amneesh";
    stateVersion = "24.05";

    packages = with pkgs; [
      htop
      nattovim
    ];
  };

  imports = [
    ./natto/emacs.nix
  ];

  xdg.mime.enable = true;
  targets.genericLinux.enable = true;
  programs.bash.enable = true;
}
