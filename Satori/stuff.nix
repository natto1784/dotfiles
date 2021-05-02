{lib, config, ... }:
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
      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_X11_NO_MITSHM="1";
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
  programs = { 
    fish.enable = true;
    dconf.enable = true;
  };
  nixpkgs.config.allowBroken = true;
  nix.extraOptions = ''experimental-features = nix-command flakes ca-references'';

}
