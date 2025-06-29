{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    grim
    slurp
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    wl-clipboard
    swayimg
    swaybg
  ];
}
