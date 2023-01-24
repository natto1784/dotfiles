{ pkgs, config, ... }:
{
  wayland = {
    windowManager = {
      sway = {
        enable = true;
      };
      hyprland = {
        enable = true;
        xwayland = {
          enable = true;
          hidpi = true;
        };
        nvidiaPatches = true;
        extraConfig = builtins.readFile ./config/hypr/hyprland.conf;
      };
    };
  };

}
