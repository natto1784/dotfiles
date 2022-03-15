{ pkgs, config, ... }:
{
  xsession = {
    pointerCursor = {
      package = pkgs.numix-cursor-theme;
      name = "Numix";
    };
    windowManager = {
      bspwm = {
        enable = false;
        extraConfig = builtins.readFile ./config/bspwm/bspwmrc;
      };
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
