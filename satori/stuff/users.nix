{config, pkgs, ... }:

{
  users.users.natto = {
    isNormalUser = true;
    shell = pkgs.fish;
    home = "/home/natto";
    extraGroups = [ "wheel" "video" "audio" ];
  };
}
