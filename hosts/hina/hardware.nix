{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/d91adce2-9059-4a8a-86e7-dee6ecc85b2b";
      fsType = "ext4";
    };

  swapDevices = [
    {
      device = "/swapfile";
      size = 7168;
      priority = 0;
    }
  ];
}
