{config, pkgs, lib, ...}:
let
  home = config.home.homeDirectory;
in
{
  imports = [
    ./stuff/programs/nvim.nix
    ./stuff/programs/emacs.nix
    ./stuff/secret.nix
  ];
 /* age = {
    sshKeyPaths = [ "${home}/.ssh/id_ed25519" ];
    secrets = {
      zshrc = {
        file = ./secrets/.zshrc.age;
        path = "${home}/.zshrc";
        mode = "660";
      };
    };
  };*/
  home = {
    packages = with pkgs; [
      pamixer
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
