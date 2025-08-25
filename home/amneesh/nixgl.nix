{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (inputs) nixgl;
  inherit (inputs.hyprland.packages.${pkgs.system}) hyprland;
  inherit (config.lib.nixGL) wrap;
in
{
  nixGL = {
    packages = nixgl.packages;
    defaultWrapper = "mesa";
    offloadWrapper = "nvidiaPrime";
    installScripts = [
      "mesa"
      "nvidiaPrime"
    ];
  };

  wayland.windowManager.hyprland.package = lib.mkForce (wrap hyprland);
}
