{ config, colors, ... }:
{
  services = {
    dunst = {
      enable = true;
      iconTheme = with config.gtk.iconTheme; { inherit name package; };
      settings = with colors.hex; {
        global = {
          mouse_left_click = "close_current";
          mouse_right_click = "do_action";
          mouse_middle_click = "close_all";
          font = "Monospace 10";
          separator_color = "auto";
          shrink = true;
          word_wrap = "yes";
        };

        urgency_low = {
          inherit background foreground;
          frame_color = sky;
          timeout = 5;
        };

        urgency_normal = {
          inherit background foreground;
          frame_color = mauve;
          timeout = 5;
        };

        urgency_critical = {
          inherit background foreground;
          frame_color = red;
          timeout = 0;
        };
      };
    };
  };
}
