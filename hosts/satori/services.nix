{ lib, config, pkgs, ... }:

{
  services = {
    tor.enable = true;
    logmein-hamachi.enable = true;
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
    btrfs.autoScrub.enable = true;
    udev.extraRules = ''
      ACTION=="add|change", KERNEL=="sda", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"
    '';
  };
  systemd.enableUnifiedCgroupHierarchy = false;
  security.pki.certificateFiles = [ ../../cert.pem ];
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu.runAsRoot = true;
  };
}
