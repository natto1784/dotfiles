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
      device = "/dev/disk/by-uuid/2424-5639";
      fsType = "vfat";
    };

  fileSystems."/media/ntfs" =
    {
      device = "/dev/disk/by-uuid/A4CC66B6CC668282";
      fsType = "ntfs";
      options = [ "uid=natto" "gid=users" "umask=0022" "rw" ];
    };

  fileSystems."/media/real" =
    {
      device = "/dev/disk/by-uuid/6372bc0c-0917-469d-a845-2ce65513e306";
      fsType = "ext4";
      options = [ "rw" ];
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
