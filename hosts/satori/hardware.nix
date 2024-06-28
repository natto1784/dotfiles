{ config, lib, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/59af143c-1a87-4654-9b31-7594ac8ba530";
      fsType = "ext4";
    };

  fileSystems."/media/real" =
    {
      device = "/dev/disk/by-uuid/8086be20-c770-46be-bd8f-5bd2d7735c7d";
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
