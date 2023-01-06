{ lib, config, pkgs, ... }:

{
  services = {
    tor.enable = true;
    logmein-hamachi.enable = true;
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
    ratbagd.enable = true;
    btrfs.autoScrub.enable = true;
    udev.extraRules = ''
      ACTION=="add|change", KERNEL=="sda", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"
    '';
    zfs.autoScrub.enable = true;
    gvfs.enable = true;
    logind.extraConfig = "RuntimeDirectorySize=30%";
  };
  systemd.services.tor.wantedBy = lib.mkForce [ ];
  systemd.enableUnifiedCgroupHierarchy = false;
  security.pki.certificateFiles = [ ../../cert.pem ];
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu.runAsRoot = true;
  };
}
