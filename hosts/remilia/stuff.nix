{ config, pkgs, ... }:
{
  time.timeZone = "Asia/Kolkata";
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
  programs = {
    gnupg = {
      agent = {
        enable = true;
        pinentryFlavor = "curses";
      };
    };
  };
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.trusted-users = [ "root" ];
  };
}
