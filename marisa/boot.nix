{config, ...}:
{
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "usb_storage" "usbhid" "uas"];
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    extraModulePackages = [ ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable= true;
      raspberryPi= {
        version = 4;
        firmwareConfig = "dtparam=sd_poll_once=on";
        enable = true;  
      };
    };
  };
}
