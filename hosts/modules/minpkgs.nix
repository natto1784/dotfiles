{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    htop
    vim
    wireguard-tools
    vault
    tree-sitter
    rnix-lsp
    nmap
    gcc
    fly
    postgresql #for the client cli
  ];
}
