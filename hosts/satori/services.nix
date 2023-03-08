{ lib, config, pkgs, ... }:

{
  services = {
    tor.enable = true;
    openssh = {
      enable = true;
      settings.permitRootLogin = "yes";
    };
    ratbagd.enable = true;
    btrfs.autoScrub.enable = true;
    zfs.autoScrub.enable = true;
    udev.extraRules = ''
      ACTION=="add|change", KERNEL=="sda", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"
    '';
    gvfs.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };
    logind.extraConfig = "RuntimeDirectorySize=30%";
  };
  systemd.services = {
    tor.wantedBy = lib.mkForce [ ];
    libvirtd.wantedBy = lib.mkForce [ ];
  };

  security.pki.certificateFiles = [ ../../cert.pem ];
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu.runAsRoot = true;
  };
}
