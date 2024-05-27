{ lib, config, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages;
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };
    kernelParams = [ "i915.force_probe=56a1" "resume_offset=11287312" ];

    #   kernelModules = [ "kvm-intel" "i2c-dev" "ddcci_backlight" ];
    kernelModules = [ "kvm-intel" "i2c-dev" ];
    #   extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback r8125 ddcci-driver ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback r8125 ];
    blacklistedKernelModules = [ "r8169" ];

    resumeDevice = "/dev/disk/by-uuid/5679b901-3a70-4422-81f5-af91f287500b";

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        splashMode = "stretch";
      };
    };
  };
}
