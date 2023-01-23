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
      QT_X11_NO_MITSHM = "1";
      HM_CONF_DIR = "/etc/nixos";
    };

    shellAliases = rec {
      ec = "emacsclient";
      ecc = ec + " -c";
      ecnw = ec + " -nw";
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
        text =
          let
            packages = builtins.map (p: "${p.name}") config.home.packages;
            sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
            formatted = builtins.concatStringsSep "\n" sortedUnique;
          in
          formatted;
        target = "${xdg.configHome}/${config.home.username}-packages";
      };
    };
  };
  i18n = {
    inputMethod = {
      #   enabled = "fcitx5";
      #  fcitx5.addons = with pkgs; [ fcitx5-m17n fcitx5-mozc ];
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [ m17n mozc ];
    };
  };
}
