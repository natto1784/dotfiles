{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fira-code
    fira-mono
    monoid
    font-awesome
    material-icons
    material-design-icons
    lohit-fonts.devanagari
    lohit-fonts.gurmukhi
    office-code-pro
    eb-garamond
    noto-fonts-cjk-sans
    takao
    liberation_ttf
  ];

  fonts.fontconfig.enable = true;
}
