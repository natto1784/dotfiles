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
  nix.gc = {
    automatic = false;
    dates = "20:15";
  };
  fonts.fonts = with pkgs; [
    fira-mono
    font-awesome
    vistafonts
    noto-fonts-cjk
  ];
  users.users.natto = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/natto";
    extraGroups = [ "wheel" "adbusers" ];
  };
}
