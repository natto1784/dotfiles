{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (nattovim.override { nvimPackage = inputs.nvim-overlay.packages.${pkgs.system}.neovim; })
  ];
}
