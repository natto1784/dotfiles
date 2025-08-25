{ pkgs, ... }:
{
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaFlamingo;
    name = "catppuccin-mocha-flamingo-cursors";
    size = 32;
    x11 = {
      enable = true;
      defaultCursor = "crosshair";
    };
    gtk.enable = true;
  };
}
