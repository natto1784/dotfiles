{config, pkgs, ...}:
{
  time.timeZone = "Asia/Kolkata";
  environment = {
    sessionVariables = {
      EDITOR = "vim";
    };
  };
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "ottan" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };
  fonts.fonts = with pkgs; [
    fira-mono
  ];
  users.users.ottan = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/ottan";
    extraGroups = [ "wheel" ];
  };
}
