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
