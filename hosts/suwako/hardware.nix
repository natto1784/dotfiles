{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/e87c20b9-f451-45bf-b863-385ac9c290cf ";
      fsType = "ext4";
    };

  swapDevices = [
    {
      device = "/swapfile";
      size = 3084;
      priority = 0;
    }
  ];
}
