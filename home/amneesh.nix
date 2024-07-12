{ config, pkgs, inputs, ... }:
{
  home = {
    homeDirectory = "/home/amneesh";
    username = "amneesh";
    stateVersion = "24.05";

    packages = with pkgs; [
      htop
      nattovim
      clang-tools
      llvmPackages.clang
    ];
  };

  imports = [
    ./natto/emacs.nix
   # ./natto/wayland.nix
  ];

  xdg.mime.enable = true;
  targets.genericLinux.enable = true;
  programs.bash.enable = true;
}
