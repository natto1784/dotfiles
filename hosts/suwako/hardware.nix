{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/cloudimg-rootfs";
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
