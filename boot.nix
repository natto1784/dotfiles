{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelPatches = [
      {
        name = "zenwithmuqqs";
        patch = null;
        structuredExtraConfig = with lib.kernel; {
          SCHED_MUQSS = yes;
          };
        ignoreConfigErrors = true;
      }
    ];
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
        splashImage = "/etc/cirno.png"; #hehe
        splashMode = "stretch";
        configurationName = "nixbruh";
      };
    };
    kernelParams = [ "nvidia-drm.modeset=1" "intel_pstate=active"]; 
  };
}
