{ pkgs, config, ... }:
{
  gtk.cursorTheme = {
    package = pkgs.numix-cursor-theme;
    name = "Numix";
  };

  xsession = {
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = hs: [ hs.xmobar ];
        config = ./config/xmonad/xmonad.hs;
        libFiles = {
          "xmobar.hs" = ./config/xmonad/xmobar.hs;
          "padding-icon.sh" = ./config/xmonad/padding-icon.sh;
          "nixos.xpm" = ./config/xmonad/nixos.xpm;
        };
      };
    };
  };
}
