{
  pkgs,
  inputs,
  ...
}:
{

  xdg.mime.enable = true;
  programs = {
    bash.enable = true;
  };

  home.packages = with pkgs; [
    cmake
    corkscrew
    dtc
    file
    htop
    llvmPackages.clang
    (nattovim.override { nvimPackage = inputs.nvim-overlay.packages.${pkgs.system}.neovim; })
    meson
    ninja
    thunderbird
    wget
    xfce.thunar
  ];
}
