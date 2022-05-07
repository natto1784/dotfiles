{ config, pkgs, ... }:
{
  boot = {
    kernelParams = [ "console=ttyS0,115200n8" "console=ttyAMA0,115200" "console=tty0" "boot.shell_on_fail" ];
    kernelPackages = pkgs.linuxPackages_5_10; 
    initrd.availableKernelModules = [ "xhci_pci" "usb_storage" "usbhid" "uas" "pcie-brcmstb" "vc4" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
      /*raspberryPi= {
        version = 4;
        firmwareConfig = "dtparam=sd_poll_once=on";
        enable = true;  
        };*/ #conflicts with generic-extlinux-comaptible
    };
    /* kernelPatches = [
      {
      name = "change-pgtable";
      patch = null;
      extraConfig = ''
      CONFIG_PGTABLE_LEVELS 4
      '';
      }
      ];*/
  };
}
