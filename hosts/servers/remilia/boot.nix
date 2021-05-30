{config, ...}:
{
  boot = {
    initrd.kernelModules = [ "bochs_drm" ];
    initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" ];
    kernelModules = [ "kvm-amd" ];
    kernelParams = [ "console=ttyS0" "console=tty1" "nvme.shutdown_timeout=10" "libiscsi.debug_libiscsi_eh=1" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
