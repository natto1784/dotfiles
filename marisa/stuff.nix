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
          users = [ ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };
  fonts.fonts = with pkgs; [
    fira-mono
  ];
  documentation.enable = false;
  users.extraUsers.root = {
      shell = pkgs.zsh;
    };
}
