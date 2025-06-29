{ pkgs, inputs, config, conf, ... }: {
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
        xwayland = {
          enable = true;
        };
        extraConfig = (builtins.readFile ./config/hypr/hyprland.conf)
          + (with config.home.pointerCursor; ''
          exec-once=hyprctl setcursor ${name} ${toString size}
        '')
          + (with conf.colors.argb { a = "ee"; };''
          general {
            col.active_border = 0x${mauve} 0x${flamingo} 135deg
            col.inactive_border = 0x${surface0}
          }
        '');
      };
    };
  };

  home.packages = with pkgs; [
    grim
    slurp
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    wl-clipboard
    swayimg
    swaybg
  ];
}
