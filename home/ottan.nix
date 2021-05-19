{config, pkgs, lib, ...}:
let
  home = config.home.homeDirectory;
in
{
  imports = [
    ./stuff/programs/nvim.nix
    ./stuff/programs/emacs.nix
  ];
  home = {
    packages = with pkgs; [
      pamixer
      customscripts
      curl
    ];
    file = {
      dwm-autostart = {
        source = ./config/dwm/autostart.sh;
        target = "${home}/.dwm/autostart.sh";
      };
      dwm-status = {
        source = ./config/dwm/bruhstatus.sh;
        target = "${home}/.dwm/bruhstatus.sh";
      };
    };
  };
}
