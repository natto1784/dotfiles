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
      options = ["compress-force=zstd:2"];
    };

  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/58B1-4631";
      fsType = "vfat";
    };
  fileSystems."/mnt/Stuff" = 
  {
    device = "/dev/disk/by-uuid/843E68573E6843F0";
    fsType = "ntfs";
    options = ["uid=natto" "gid=users" "umask=0022" "rw"];
  };
  fileSystems."/mnt/Extra" = 
  { 
    device = "/dev/disk/by-uuid/32EE9F63EE9F1DE3";
    fsType = "ntfs";
    options = ["uid=natto" "gid=users" "umask=0022" "rw"];
  };
  fileSystems."/mnt/Games" = 
  {
    device = "/dev/disk/by-uuid/A4CC66B6CC668282";
    fsType = "ntfs";
    options = ["uid=natto" "gid=users" "umask=0022" "rw"];
  };
  fileSystems."/mnt/Stuff2" =
    {
      device = "/dev/disk/by-uuid/e5be3621-8608-4ffe-bd33-5e6d22fef4ff";
      fsType = "btrfs";
      options = ["compress-force=zstd:1"];
    };
  swapDevices = [ {device = "/dev/nvme0n1p7";} ];
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };
}
