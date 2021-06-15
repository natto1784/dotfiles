{pkgs, config, ...}:
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
        config = ../config/xmonad/xmonad.hs;
        libFiles = {
          "xmobar.hs" = ../config/xmonad/xmobar.hs;
        };
      };
    };
  };
}
