{ lib, config, pkgs, ... }:

{
  boot = {
    supportedFilesystems = [ "zfs" ];

    kernelPackages = pkgs.unstable.linuxPackages_latest;
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "vfio-pci" ];
      /*     preDeviceCommands = ''
        DEVS="0000:01:00.0 0000:01:00.1 0000:01:00.2 0000:01:00.3"
        for DEV in $DEVS; do
        echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
        done
        modprobe -i vfio-pci
        '';*/
      kernelModules = [ ];
    };
    kernelParams = [ "intel_pstate=active" "intel_iommu=on" ];
    kernelModules = [ "kvm-intel" "snd-seq" "snd-rawmidi" "joydev" ];
    extraModulePackages = with config.boot.kernelPackages; [ nvidia_x11_vulkan_beta v4l2loopback ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        #       useOSProber = true;
        efiSupport = true;
        device = "nodev";
        splashImage = ./cirno.png;
        splashMode = "stretch";
        configurationName = "nixbruh";
      };
    };
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
