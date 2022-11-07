{ config, lib, pkgs, ... }: {
  home =
    let
      home = config.home.homeDirectory;
    in
    {
      sessionVariables = {
        LV2_PATH = lib.makeSearchPath "lib/lv2" (with pkgs; [ calf ]);
        TERM = "st-24bits";
      };
      file = {
        dunstrc = {
          source = ./config/dunst/dunstrc;
          target = "${home}/.config/dunst/dunstrc";
        };
        stalonetray = {
          source = ./config/stalonetrayrc;
          target = "${home}/.stalonetrayrc";
        };
        ncmpcpp = {
          source = ./config/ncmpcpp/config;
          target = "${home}/.config/ncmpcpp/config";
        };
        mpv = {
          source = ./config/mpv/mpv.conf;
          target = "${home}/.config/mpv/mpv.conf";
        };
      };
    };
}
