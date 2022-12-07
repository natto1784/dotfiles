{ config, pkgs, inputs, ... }:
{
  home.file = with config; {
    "config.org" = {
      source = ./config/emacs/config.org;
      target = "${home.homeDirectory}/.emacs.d/config.org";
    };
    "init.el" = {
      source = ./config/emacs/init.el;
      target = "${home.homeDirectory}/.emacs.d/init.el";
    };
  };

  services = {
    emacs =
      let
        mymacs = config: # with inputs.emacs-overlay.packages.${pkgs.system}; already resolved with overlay
          with pkgs; emacsWithPackagesFromUsePackage {
            inherit config;
            package = emacsGit;
            alwaysEnsure = true;
            alwaysTangle = true;
            extraEmacsPackages = epkgs: with epkgs; [
              use-package
              (epkgs.tree-sitter-langs.withPlugins (_: epkgs.tree-sitter-langs.plugins))
            ];
          };
      in
      {
        enable = true;
        package = mymacs ./config/emacs/config.org;
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
      extraConfig = builtins.readFile ./config/mpd/mpd.conf;
    };

    mpd-discord-rpc = {
      enable = true;
      settings = {
        id = 1039532008424099850; # dont really care
        format = {
          large_image = "koishi";
          small_image = "";
          large_text = "real";
          small_text = "the";
        };
      };
    };

    dunst = {
      enable = true;
      settings = {
        global = {
          font = "Monospace 10";
          frame_color = "#93a1a1";
          separator_color = "#93a1a1";
          shrink = true;
          icon_theme = config.gtk.iconTheme.name;
        };

        urgency_low = {
          background = "#586e75";
          foreground = "#eee8d5";
          timeout = 5;
        };

        urgency_normal = {
          background = "#073642";
          foreground = "#eee8d5";
          timeout = 5;
        };

        urgency_critical = {
          background = "#dc322f";
          foreground = "#eee8d5";
          timeout = 0;
        };
      };
    };

  };

  systemd.user.services = {
    mpd-discord-rpc = {
      Service = {
        Restart = "on-failure";
        RestartSec = "15s";
      };
    };

    mpdas = {
      Unit = {
        After = [ "mpd.service" ];
        Description = "Music Player Daemon AutoScrobbler";
      };

      Install.WantedBy = [ "default.target" ];

      Service = {
        Type = "simple";
        Restart = "on-failure";
        RestartSec = "15s";
        ExecStart = "${pkgs.mpdas}/bin/mpdas -c ${config.age.secrets.mpdasrc.path}";
      };
    };
  };
}
