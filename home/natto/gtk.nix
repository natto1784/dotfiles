{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Teal-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "teal" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };
}
