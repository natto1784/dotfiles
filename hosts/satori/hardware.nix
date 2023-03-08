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

  fileSystems."/media/real" =
    {
      device = "/dev/disk/by-uuid/8086be20-c770-46be-bd8f-5bd2d7735c7d";
      fsType = "btrfs";
      options = [ "rw" ];
    };

  fileSystems."/media/ntfs" =
    {
      device = "/dev/disk/by-uuid/A4CC66B6CC668282";
      fsType = "ntfs";
      options = [ "uid=natto" "gid=users" "umask=0022" "rw" ];
    };

  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 30;
    priority = -1;
  };

  swapDevices = [
    { device = "/var/swap"; size = 4096; }
  ];

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  hardware = {
    bluetooth.enable = true;
  };
}
