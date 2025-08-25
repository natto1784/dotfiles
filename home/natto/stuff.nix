{
  config,
  lib,
  pkgs,
  ...
}:
{
  xdg = {
    enable = true;
    userDirs.enable = true;
  };

  age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];

  home = {
    sessionVariables = {
      QT_X11_NO_MITSHM = "1";
      HM_CONF_DIR = "/etc/nixos";
      QT_QPA_PLATFORMTHEME = "gtk2";
    };
  };
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-m17n
        fcitx5-mozc
      ];
    };
  };
}
