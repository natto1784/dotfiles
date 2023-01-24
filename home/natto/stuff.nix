{ config, lib, pkgs, ... }: {
  xdg = {
    enable = true;
    userDirs.enable = true;
  };

  age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];

  home = {
    sessionVariables = {
      LV2_PATH = lib.makeSearchPath "lib/lv2" (with pkgs; [ calf ]);
      QT_X11_NO_MITSHM = "1";
      HM_CONF_DIR = "/etc/nixos";
      QT_QPA_PLATFORMTHEME = "gtk2";
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
      mpv = {
        source = ./config/mpv/mpv.conf;
        target = "${xdg.configHome}/mpv/mpv.conf";
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
