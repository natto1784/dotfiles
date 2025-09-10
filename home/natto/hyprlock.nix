{
  config,
  pkgs,
  conf,
  ...
}:
{
  programs.hyprlock = {
    enable = true;

    settings = with conf.colors.argb { a = "ee"; }; {
      general = {
        hide_cursor = false;
      };

      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 2;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = 4;
          valign = "center";
          halign = "center";

          font_color = "0x${text}";
          outer_color = "0x${mauve}";
          inner_color = "0x${surface0}";
          check_color = "0x${blue}";
          fail_color = "0x${red}";
          capslock_color = "0x${yellow}";

          fade_on_empty = false;
          hide_input = false;
          placeholder_text = "Logged in as <b>$USER</b>";
          fail_text = "Fail! <b>($ATTEMPTS)</b>";

          dots_spacing = 0.2;
          dots_center = true;
        }
      ];

      label = [
        {
          monitor = "";
          text = "Layout: $LAYOUT";
          font_size = 25;
          color = "0x${text}";
          position = "2%, -2%";
          valign = "top";
          halign = "left";
        }
        {
          monitor = "";
          text = "$TIME";
          font_size = 90;
          color = "0x${text}";
          position = "-2%, 0";
          valign = "top";
          halign = "right";
        }
        {
          monitor = "";
          text = "cmd[update:3600000] date +\"%A, %d %B %Y\"";
          font_size = 25;
          color = "0x${text}";
          position = "-2%, -10%";
          valign = "top";
          halign = "right";
        }
      ];
    };
  };
}
