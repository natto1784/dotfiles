{lib, config, pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    fira-mono
    font-awesome-ttf
    powerline-fonts
    vistafonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];
}
