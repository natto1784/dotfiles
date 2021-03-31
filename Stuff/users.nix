{lib, config, pkgs, ... }:

{
  users.users.otaku619 = {
    isNormalUser = true;
    shell = pkgs.fish;
    home = "/home/otaku619";
    extraGroups = [ "wheel" "video" "audio" ];
  };
}
