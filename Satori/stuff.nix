{lib, config, agenix, ... }:
{
  imports = [
    ./Stuff/sound.nix
    ./Stuff/fonts.nix
    ./Stuff/users.nix
    ./Stuff/services.nix
    ./Stuff/xorg.nix
  ];
  time.timeZone = "Asia/Kolkata";
  environment = {
    sessionVariables = {
      QT_X11_NO_MITSHM="1";
      EDITOR = "nvim";
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
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
}
