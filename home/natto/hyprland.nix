{
  pkgs,
  inputs,
  config,
  lib,
  conf,
  ...
}:
{
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;

        package = inputs.hyprland.packages.${pkgs.system}.hyprland;

        portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;

        xwayland = {
          enable = true;
        };

        settings = {
          monitor = ", highrr, auto, 1";

          input = {
            kb_layout = "us,us";
            kb_variant = "colemak_dh";
            kb_model = "";
            kb_options = "grp:rctrl_toggle";
            kb_rules = "";
            repeat_delay = 300;
            accel_profile = "flat";
            follow_mouse = true;

            touchpad = {
              natural_scroll = true;
              scroll_factor = 0.4;
            };
          };

          general = with conf.colors.argb { a = "ee"; }; {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 2;
            layout = "dwindle";
            "col.active_border" = "0x${mauve} 0x${flamingo} 135deg";
            "col.inactive_border" = "0x${surface0}";
          };

          decoration = {
            rounding = 1;
            inactive_opacity = 0.8;

            shadow = {
              enabled = true;
            };

            blur = {
              enabled = true;
              size = 8;
              new_optimizations = true;
              xray = true;
            };
          };

          animations = {
            enabled = true;

            bezier = [
              "overshot,0.01,0.9,0.1,1.05"
              "easeoutexpo,0.16,1,0.3,1"
            ];

            animation = [
              "windows,1,7,overshot,popin 50%"
              "windowsOut,1,7,easeoutexpo,popin 50%"
              "border,1,10,default"
              "fade,1,7,default"
              "workspaces,1,6,overshot"
            ];
          };

          cursor = {
            no_hardware_cursors = true;
          };

          dwindle = {
            pseudotile = true;
            preserve_split = true;
          };

          misc = {
            disable_hyprland_logo = true;
          };

          "$mod" = "SUPER";

          bind =
            let
              playerctl = "playerctl -p 'playerctld,%any'";
            in
            [
              # Hyprland operations
              "$mod ALT, f, exit,"
              "$mod SHIFT, t, pseudo,"
              "$mod, f, fullscreen,"
              "$mod, t, togglefloating,"
              "$mod, left, movefocus, l"
              "$mod, h, movefocus, l"
              "$mod, right, movefocus, r"
              "$mod, l, movefocus, r"
              "$mod, up, movefocus, u"
              "$mod, k, movefocus, u"
              "$mod, down, movefocus, d"
              "$mod, j, movefocus, d"
              "$mod, 1, workspace, 1"
              "$mod, 2, workspace, 2"
              "$mod, 3, workspace, 3"
              "$mod, 4, workspace, 4"
              "$mod, 5, workspace, 5"
              "$mod, 6, workspace, 6"
              "$mod, 7, workspace, 7"
              "$mod, 8, workspace, 8"
              "$mod, 9, workspace, 9"
              "$mod, 0, workspace, 10"
              "$mod SHIFT, 1, movetoworkspacesilent, 1"
              "$mod SHIFT, 2, movetoworkspacesilent, 2"
              "$mod SHIFT, 3, movetoworkspacesilent, 3"
              "$mod SHIFT, 4, movetoworkspacesilent, 4"
              "$mod SHIFT, 5, movetoworkspacesilent, 5"
              "$mod SHIFT, 6, movetoworkspacesilent, 6"
              "$mod SHIFT, 7, movetoworkspacesilent, 7"
              "$mod SHIFT, 8, movetoworkspacesilent, 8"
              "$mod SHIFT, 9, movetoworkspacesilent, 9"
              "$mod SHIFT, 0, movetoworkspacesilent, 10"
              "$mod SHIFT, comma, focusmonitor, -1"
              "$mod SHIFT, period, focusmonitor, +1"

              # Launchers
              "$mod, RETURN, exec, foot"
              "$mod, D, exec, pkill tofi || tofi-drun | xargs hyprctl dispatch exec --"
              "$mod SHIFT, D, exec, pkill tofi || tofi-run --require-match=false | xargs hyprctl dispatch exec --"

              # Media
              ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
              ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
              ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

              # Backlight
              ", XF86MonBrightnessUp, exec, light -A 5"
              ", XF86MonBrightnessDown, exec, light -U 5"

              # XWayland Keymaps
              "$mod SHIFT, F1, exec, setxkbmap us colemak_dh"
              "$mod SHIFT, F2, exec, setxkbmap us basic"

              # Screenshot
              ", PRINT, exec, grimblast --notify copysave screen"
              "SHIFT, PRINT, exec, grimblast --notify copysave area"

              # Playerctl
              "$mod, P, exec, ${playerctl} play-pause"
              ", XF86AudioPlay, exec, ${playerctl} play-pause"
              ", XF86AudioNext, exec, ${playerctl} position 5+"
              ", XF86AudioPrev, exec, ${playerctl} position 5-"
              "$mod, XF86AudioNext, exec, ${playerctl} next"
              "$mod, XF86AudioPrev, exec, ${playerctl} previous"
            ];

          binde = [
            # Hyprland operations
            "$mod SHIFT, Q, killactive,"
            "$mod SHIFT, left, movewindow, l"
            "$mod SHIFT, h, movewindow, l"
            "$mod SHIFT, right, movewindow, r"
            "$mod SHIFT, l, movewindow, r"
            "$mod SHIFT, up, movewindow, u"
            "$mod SHIFT, k, movewindow, u"
            "$mod SHIFT, down, movewindow, d"
            "$mod SHIFT, j, movewindow, d"
            "SHIFT ALT, left, resizeactive, -10 0"
            "SHIFT ALT, h, resizeactive, -10 0"
            "SHIFT ALT, right, resizeactive, 10 0"
            "SHIFT ALT, l, resizeactive, 10 0"
            "SHIFT ALT, up, resizeactive, 0 -10"
            "SHIFT ALT, k, resizeactive, 0 -10"
            "SHIFT ALT, down, resizeactive, 0 10"
            "SHIFT ALT, j, resizeactive, 0 10"
          ];

          bindm = [
            # Mouse
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
            "$mod ALT, mouse:272, resizewindow"
          ];

          exec-once = [
            (with config.home.pointerCursor; "hyprctl setcursor ${name} ${toString size} ")
          ]
          ++ (with config.programs; lib.optional eww.enable "${eww.package}/bin/eww open bar");
        };
      };
    };
  };
}
