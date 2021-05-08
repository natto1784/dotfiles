{pkgs, config, ...}:
{
  xsession = {
    windowManager.bspwm = {
      enable = false;
      extraConfig = builtins.readFile ./config/bspwm/bspwmrc;
    };
  };
}
