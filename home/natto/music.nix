{ config, pkgs, ... }:
let
  home = config.home.homeDirectory;
in
{
  services = rec {
    mpd = {
      enable = true;
      musicDirectory = "${home}/Music";
      dbFile = "${home}/.config/mpd/database";
      dataDir = "${home}/.config/mpd";
      network = {
        startWhenNeeded = true;
        listenAddress = "any";
        port = 6600;
      };
      extraConfig = builtins.readFile ./config/mpd/mpd.conf;
    };

    mpd-discord-rpc = {
      #     inherit (mpd) enable;
      enable = false;
      settings = {
        id = 1039532008424099850; # dont really care
        format = {
          large_image = "koishi";
          small_image = "koishifumo";
          large_text = "real";
          small_text = "the";
        };
      };
    };

    mpdris2 = {
      inherit (mpd) enable;
      mpd = {
        inherit (mpd) musicDirectory;
        host = "localhost";
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

  home = {
    packages = with pkgs; [
      playerctl
      mpc_cli
      (ncmpcpp.override {
        visualizerSupport = true;
        clockSupport = true;
      })
      (tauon.override {
        withDiscordRPC = true;
      })
    ];

    file.ncmpcpp = {
      source = ./config/ncmpcpp/config;
      target = "${config.xdg.configHome}/ncmpcpp/config";
    };

    sessionVariables = {
      # LV2_PATH = lib.makeSearchPath "lib/lv2" (with pkgs; [ calf ]);
    };
  };


  age.secrets.mpdasrc = {
    file = ./secrets/mpdasrc.age;
    path = "${home}/.config/mpdasrc";
    symlink = false;
  };
}
