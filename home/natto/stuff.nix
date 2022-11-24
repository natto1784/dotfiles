{ config, lib, pkgs, ... }: {
  xdg = {
    enable = true;
    userDirs.enable = true;
  };

  home = {
    sessionVariables = {
      LV2_PATH = lib.makeSearchPath "lib/lv2" (with pkgs; [ calf ]);
      TERM = "st-24bits";
    };
    file = with config; {
      stalonetray = {
        source = ./config/stalonetrayrc;
        target = "${home.homeDirectory}/.stalonetrayrc";
      };
      ncmpcpp = {
        source = ./config/ncmpcpp/config;
        target = "${xdg.configHome}/ncmpcpp/config";
      };
      mpv = {
        source = ./config/mpv/mpv.conf;
        target = "${xdg.configHome}/mpv/mpv.conf";
      };
    };
  };
}
