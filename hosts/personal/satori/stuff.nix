{config, agenix, pkgs, ... }:
{
  time.timeZone = "Asia/Kolkata";
  environment = {
    sessionVariables = {
      QT_X11_NO_MITSHM="1";
      QT_QPA_PLATFORMTHEME = "gtk3";
    };
  };
  security={
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "natto" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };
  fonts.fonts = with pkgs; [
    fira-mono
    noto-fonts-cjk
    lohit-fonts.devanagari
    lohit-fonts.gurmukhi
    nerdfonts
    font-awesome
  ];
  users.users.natto = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/natto";
    extraGroups = [ "wheel" "adbusers" "video" "libvirtd" ];
  };
  i18n.inputMethod = {
 #   enabled = "fcitx5";
 #  fcitx5.addons = with pkgs; [ fcitx5-m17n fcitx5-mozc ];
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ m17n mozc ];
  };
}
