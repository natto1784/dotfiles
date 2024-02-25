{ pkgs, config, lib', inputs, ... }:
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
        };
        extraConfig = (builtins.readFile ./config/hypr/hyprland.conf)
          + (with config.home.pointerCursor; ''
          exec-once=hyprctl setcursor ${name} ${toString size}
        '')
          + (with lib'.colors.argb { a = "ee"; };''
          general {
            col.active_border = 0x${mauve} 0x${flamingo} 135deg
            col.inactive_border = 0x${surface0}
          }
        '');
      };
    };
  };

  home.file.tofi = {
    source = pkgs.writeText "tofi-config" (pkgs.lib.generators.toKeyValue { } (with lib'.colors.default; {
      # https://github.com/philj56/tofi/blob/master/themes/fullscreen
      width = "100%";
      height = "100%";
      border-width = 0;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
      num-results = 5;
      font = "Fira Mono";
      font-size = 15;
      text-color = foreground;
      selection-color = rosewater;
      selection-match-color = red;
      background-color = "#000A";
    }));
    target = "${config.xdg.configHome}/tofi/config";
  };

  home.packages = with pkgs; [
    tofi
    imv
    grim
    slurp
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    wl-clipboard
    swaybg
  ];
}
