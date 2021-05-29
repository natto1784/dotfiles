{lib, config, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_zen.override {
      structuredExtraConfig = with lib.kernel; {
        CONFIG_SCHED_MUQSS = yes;
      };
      ignoreConfigErrors = true;
      });
    initrd={
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod"];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel"];
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        useOSProber = true;
        efiSupport =  true;
        device = "nodev";
        splashImage = ./cirno.png;
        splashMode = "stretch";
        configurationName = "nixbruh";
      };
    };
    kernelParams = [ "nvidia-drm.modeset=1" "intel_pstate=active"]; 
  };
}
