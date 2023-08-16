{ config, ... }:
{
  boot = {
    kernel.sysctl."net.ipv4.ip_forward" = 1;
    initrd.kernelModules = [ "bochs" ];
    initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" ];
    kernelModules = [ "kvm-amd" ];
    kernelParams = [ "console=ttyS0" "console=tty1" "nvme.shutdown_timeout=10" "libiscsi.debug_libiscsi_eh=1" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
