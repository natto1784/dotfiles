{ config, lib, pkgs, ... }: {
  home = {
    sessionVariables = {
      LV2_PATH = lib.makeSearchPath "lib/lv2" (with pkgs; [ calf ]);
      TERM = "st-24bits";
    };
    file = with config; {
      dunstrc = {
        source = ./config/dunst/dunstrc;
        target = "${xdg.configHome}/dunst/dunstrc";
      };
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
