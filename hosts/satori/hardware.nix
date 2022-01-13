{ config, lib, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/4c02ddf5-d00e-4d84-856f-c327ae44d047";
      fsType = "btrfs";
      options = [ "compress-force=zstd:3" ];
    };

  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/58B1-4631";
      fsType = "vfat";
    };
  fileSystems."/mnt/Games" =
    {
      device = "/dev/disk/by-uuid/A4CC66B6CC668282";
      fsType = "ntfs";
      options = [ "uid=natto" "gid=users" "umask=0022" "rw" ];
    };
  fileSystems."/mnt/Stuff" =
    {
      device = "/dev/disk/by-uuid/e5be3621-8608-4ffe-bd33-5e6d22fef4ff";
      fsType = "btrfs";
      options = [ "compress-force=zstd:3" ];
    };
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 30;
    priority = -1;
  };
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };
  hardware = {
    bluetooth.enable = true;
  };
}
