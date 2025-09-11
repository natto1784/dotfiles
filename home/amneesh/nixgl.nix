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

  # hyprland
  wayland.windowManager.hyprland.package = lib.mkForce (wrap hyprland);

  # hypridle
  services.hypridle.package = lib.mkForce (wrap pkgs.hypridle);
}
