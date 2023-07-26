{ lib, config, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
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
    kernelParams = [ "intel_pstate=active" "intel_iommu=on" "nvidia_drm.modeset=1" "clearcpuid=512" ];
    kernelModules = [ "kvm-intel" "snd-seq" "snd-rawmidi" "joydev" ];
    extraModulePackages = with config.boot.kernelPackages; [ nvidia_x11 v4l2loopback ];
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
        theme = pkgs.stdenvNoCC.mkDerivation rec {
          version = "1.2.0";
          name = "minegrub-theme";
          src = pkgs.fetchFromGitHub {
            owner = "Lxtharia";
            repo = "minegrub-theme";
            rev = "v${version}";
            sha256 = "sha256-n/fJSFrrPPyTBS8/XHaARyCxccRZiqPhhNFq0x8Q2kA=";
          };
          installPhase = "cp -r . $out";
        };
        #splashImage = ./cirno.png;
        splashMode = "stretch";
        configurationName = "nixbruh";
      };
    };
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
