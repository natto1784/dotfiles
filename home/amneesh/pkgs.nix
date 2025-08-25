{
  pkgs,
  inputs,
  ...
}:
{

  xdg.mime.enable = true;
  programs.bash.enable = true;

  home.packages = with pkgs; [
    htop
    clang-tools
    llvmPackages.clang
    (nattovim.override { nvimPackage = inputs.nvim-overlay.packages.${pkgs.system}.neovim; })
  ];
}
