{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home = {
    homeDirectory = "/home/amneesh";
    username = "amneesh";
    stateVersion = "24.05";
  };

  targets.genericLinux.enable = true;

  imports = [
    ./pkgs.nix
    ./nixgl.nix
    # wayland
    ./hyprlock.nix
    ./screen.nix
    ./wayvnc.nix

    # From personal
    ../natto/ags
    ../natto/emacs.nix
    ../natto/browser.nix
    ../natto/dunst.nix
    ../natto/gtk.nix
    ../natto/cursor.nix
    # wayland
    ../natto/wayland.nix
    ../natto/hypridle.nix
    ../natto/hyprlock.nix
    ../natto/hyprpaper.nix
    ../natto/hyprland.nix
    ../natto/tofi.nix
    ../natto/foot.nix
  ];
}
