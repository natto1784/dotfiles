{ config, lib, pkgs, ... }: {
  xdg = {
    enable = true;
    userDirs.enable = true;
  };

  age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];

  home = {
    pointerCursor = {
      package = pkgs.catppuccin-cursors.mochaFlamingo;
      name = "Catppuccin-Mocha-Flamingo-Cursors";
      size = 32;
      x11 = {
        enable = true;
        defaultCursor = "crosshair";
      };
      gtk.enable = true;
    };

    sessionVariables = {
      LV2_PATH = lib.makeSearchPath "lib/lv2" (with pkgs; [ calf ]);
      QT_X11_NO_MITSHM = "1";
      HM_CONF_DIR = "/etc/nixos";
      QT_QPA_PLATFORMTHEME = "gtk2";
    };

  };
  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-m17n fcitx5-mozc ];
    };
  };
}
