{ lib, config, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages;
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };
    kernelParams = [ "i915.force_probe=56a1" ];

    #   kernelModules = [ "kvm-intel" "i2c-dev" "ddcci_backlight" ];
    kernelModules = [ "kvm-intel" "i2c-dev" ];
    #   extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback r8125 ddcci-driver ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback r8125 ];
    blacklistedKernelModules = [ "r8169" ];
    extraModprobeConfig = '' options snd-intel-dspcfg dsp_driver=1 '';

    resumeDevice = "/dev/disk/by-uuid/3770e3bd-a200-4e36-b3a5-4963d13865f9";

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
