{ lib, config, pkgs, ... }:
{
  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
    };
    ratbagd.enable = true;
    btrfs.autoScrub.enable = true;
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
    libvirtd.wantedBy = lib.mkForce [ ];
  };

  security.pki.certificateFiles = [ ../../cert.pem ];
  virtualisation = {
    docker = {
      enable = true;
      enableNvidia = true;
    };
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu.runAsRoot = true;
    };
  };
}
