{ config, lib, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
  
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4c02ddf5-d00e-4d84-856f-c327ae44d047";
      fsType = "btrfs";
      options = ["compress=zstd:10"];
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/58B1-4631";
      fsType = "vfat";
    };
  
  fileSystems."/home" =
   { device = "/dev/nvme0n1p6";
     fsType = "ext4";
   };

  fileSystems."/mnt/Stuff" = 
  { device = "/dev/sda2";
    fsType = "ntfs";
    options = ["uid=natto" "gid=users" "umask=0022" "rw"];
  };
  fileSystems."/mnt/Games" = 
  { device = "/dev/sda4";
    fsType = "ntfs";
    options = ["uid=natto" "gid=users" "umask=0022" "rw"];
  };
  fileSystems."/mnt/Extra" = 
  { device = "/dev/sda3";
    fsType = "ntfs";
    options = ["uid=natto" "gid=users" "umask=0022" "rw"];
  };
  fileSystems."/mnt/LinuxGames" = 
  { device = "/dev/sda5";
    fsType = "btrfs";
    options = ["rw"];
  };

  swapDevices = [ {device = "/dev/nvme0n1p7";} ];
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };
}
