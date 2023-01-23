{ pkgs, config, ... }:
{
  wayland = {
    windowManager = {
      sway = {
        enable = true;
      };
      hyprland = {
        enable = false;
        xwayland = {
          enable = true;
          hidpi = true;
        };
        nvidiaPatches = true;
      };
    };
  };

}
