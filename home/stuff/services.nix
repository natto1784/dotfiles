{config, pkgs, ...}:
let
  home = config.home.homeDirectory;
in
  {
    services = {
      picom = {
        enable = true;
        extraOptions = 
        ''
          shadow = true;
          shadow-radius = 7;
          shadow-offset-x = -7;
          shadow-offset-y = -7;
           blurExclude = [ "class_g = 'dwm'" ];

          inactive-opacity = 0.92;
          active-opacity = 0.97;
          inactive-opacity-override = true;
          blur-background = true;
          blur-method = "dual_kawase";
          blur-strength = 3;
          blur-kern = "3x3box";
          fading = true;
          fade-in-step = 0.05;
          fade-out-step = 0.05;

          backend = "glx";
          detect-rounded-corners = true;
          detect-client-opacity = true;
          experimental-backends = true;
          vsync = false;
          wintypes:
          {
            tooltip = { fade = true; shadow = true; opacity = 0.75; focus = true; };
            popup_menu={opacity=0.8;};
            dropdown_menu={opacity=0.8;};
          };
          shadow-exclude = ["x = 0 && y = 0 && override_redirect = true"]
          '';

      };
      sxhkd = {
        enable = false;
        extraConfig = builtins.readFile ./config/sxhkd/sxhkdrc;
      };
    };
  }
