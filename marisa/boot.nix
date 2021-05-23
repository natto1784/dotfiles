{config, ...}:
{
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "usb_storage" "usbhid" "uas"
"ahci"

      "ata_piix"

      "sata_inic162x" "sata_nv" "sata_promise" "sata_qstor"
      "sata_sil" "sata_sil24" "sata_sis" "sata_svw" "sata_sx4"
      "sata_uli" "sata_via" "sata_vsc"

      "vc4"

      "pcie-brcmstb"

      # Rockchip
      "dw-hdmi"
      "dw-mipi-dsi"
      "rockchipdrm"
      "rockchip-rga"
      "phy-rockchip-pcie"
      "pcie-rockchip-host"

      # Misc. uncategorized hardware

      # Used for some platform's integrated displays
      "panel-simple"
      "pwm-bl"

      # Power supply drivers, some platforms need them for USB
      "axp20x-ac-power"
      "axp20x-battery"
      "pinctrl-axp209"
      "mp8859"

      # USB drivers
      "xhci-pci-renesas"
];
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
