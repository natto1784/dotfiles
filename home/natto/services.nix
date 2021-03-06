{ config, pkgs, ... }:
let
  home = config.home.homeDirectory;
in
{
  services = {
    baremacs = {
      enable = true;
      package = pkgs.mymacs ./config/emacs/config.org;
      defaultEditor = {
        enable = false;
        editor = "emacsclient";
      };
      copyConfigFiles = {
        enable = true;
        files = {
          "config.org" = ./config/emacs/config.org;
          "init.el" = ./config/emacs/init.el;
        };
      };
    };
    picom = {
      experimentalBackends = true;
      enable = true;
      shadow = true;
      shadowOffsets = [ (6) (6) ];
      shadowExclude = [
        "! name~=''"
        "window_type = 'dock'"
        "name = 'Dunst'"
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      ];
      blur = true;
      blurExclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g = 'dwm'"
      ];
      inactiveOpacity = "0.92";
      activeOpacity = "0.97";
      fade = true;
      fadeSteps = [ "0.04" "0.04" ];
      backend = "glx";
      menuOpacity = "0.8";
      vSync = false;
      opacityRule = [
        "100:class_i='Tauon Music Box'"
        "100:class_g='firefox'"
      ];
      extraOptions =
        ''
          shadow-radius = 8;
          inactive-opacity-override = true;
          blur-method = "dual_kawase";
          blur-strength = 3;
          blur-kern = "11x11gaussian";
          detect-rounded-corners = true;
          detect-client-opacity = true;
        '';
    };
    sxhkd = {
      enable = false;
      extraConfig = builtins.readFile ./config/sxhkd/sxhkdrc;
    };

    mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
      dbFile = "${config.home.homeDirectory}/.config/mpd/database";
      dataDir = "${config.home.homeDirectory}/.config/mpd";
      network = {
        startWhenNeeded = true;
        listenAddress = "any";
        port = 6600;
      };
      extraConfig = ''
        log_file                        "~/.config/mpd/log"
        pid_file                        "~/.config/mpd/pid"
        bind_to_address                 "0.0.0.0"
        bind_to_address                 "~/.config/mpd/socket"
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
        audio_output {
                encoder     "vorbis"
                type        "httpd"
                quality     "9"
                name        "Vorbis Stream"
                port        "8001"
                max_clients "4"
        }
        filesystem_charset "UTF-8"
      '';
    };
    stalonetray = {
      enable = true;
      config = {
        geometry = "1x1-0";
        max_geometry = "10x0";
        window_type = "dock";
        sticky = true;
        icon_size = 23;
        background = "#002b36";
        icon_gravity = "E";
        grow_gravity = "E";
        kludges = "force_icons_size";
        window_layer = "top";
      };
    };
  };
}
