{ config, lib, pkgs, ... }: {
  xdg = {
    enable = true;
    userDirs.enable = true;
  };

  home = {
    sessionVariables = {
      LV2_PATH = lib.makeSearchPath "lib/lv2" (with pkgs; [ calf ]);
      TERM = "st-24bits";
      QT_QPA_PLATFORMTHEME = "gtk2";
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
      packages = {
        text = let
          packages = builtins.map (p: "${p.name}") config.home.packages;
          sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
          formatted = builtins.concatStringsSep "\n" sortedUnique;
          in formatted;
        target = "${xdg.configHome}/${config.home.username}-packages";
      };
    };
  };
}
