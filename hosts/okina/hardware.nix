{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5679b901-3a70-4422-81f5-af91f287500b";
    fsType = "btrfs";
    options = [ "compress-force=zstd:3" ];
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/A2E5-006F";
    fsType = "vfat";
  };

  fileSystems."/media/omghi" = {
    device = "/dev/disk/by-uuid/0e862bdb-168a-42cc-8a28-0ae9e9a0753c";
    fsType = "ext4";
  };

  fileSystems."/media/real" = {
    device = "/dev/disk/by-uuid/8086be20-c770-46be-bd8f-5bd2d7735c7d";
    fsType = "btrfs";
    options = [ "compress-force=zstd:3" ];
  };

  /*
    fileSystems."/media/ntfs" =
    {
      device = "/dev/disk/by-uuid/54034ca6-d3cd-11ee-9e0c-f020ff87c985";
      fsType = "ntfs";
    };
  */

  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 20;
    priority = -1;
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/3770e3bd-a200-4e36-b3a5-4963d13865f9"; }
  ];

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  hardware = {
    steam-hardware.enable = true;
    bluetooth.enable = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics = {
      enable32Bit = true;
      enable = true;
      package = pkgs.mesa;
      package32 = pkgs.pkgsi686Linux.mesa;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
        vpl-gpu-rt
      ];
    };
  };
}
