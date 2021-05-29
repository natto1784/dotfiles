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
          shadow-radius = 20;
          shadow-offset-x = -20;
          shadow-offset-y = -20;
          blurExclude = [ "class_g = 'dwm'" ]

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

      mpd = {
        enable = true;
        musicDirectory = "${config.home.homeDirectory}/Music";
        extraConfig = ''
          playlist_directory              "~/.config/mpd/playlists"
          db_file                         "~/.config/mpd/database"
          log_file                        "~/.config/mpd/log"
          pid_file                        "~/.config/mpd/pid"
          state_file                      "~/.config/mpd/state"
          bind_to_address                 "~/.config/mpd/socket"
          bind_to_address                 "localhost"
          port                            "6600"
          restore_paused "yes"
          input {
                  plugin "curl"
          }
          audio_output {
                  type "pulse"
                  name "pulse audio"
          }
          audio_output {
                  type "fifo"
                  name "Visualizer feed"
                  path "/tmp/g.fifo"
                  format "44100:16:2"
          }
          filesystem_charset "UTF-8"
          '';
        network.startWhenNeeded = true;
      };
    };
  }
