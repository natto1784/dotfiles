{ inputs, pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    extraPortals = [
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
  };
}
