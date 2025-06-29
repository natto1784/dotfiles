{ lib, config, pkgs, ... }:
{
  time.timeZone = "Asia/Kolkata";

  environment.localBinInPath = true;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.enable = true;
  };
  console.useXkbConfig = true;


  users.users.natto = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/natto";
    extraGroups = [ "wheel" "adbusers" "video" "libvirtd" "docker" "networkmanager" "dialout" ];
  };

  virtualisation = {
    waydroid.enable = true;
    containers.cdi.dynamic.nvidia.enable = true;
    podman = {
      enable = true;
    };
  };

  gtk.iconCache.enable = true;
}
