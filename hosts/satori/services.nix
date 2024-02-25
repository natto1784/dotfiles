{ lib, config, pkgs, ... }:
{
  services = {
    tor.enable = true;
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
    mysql.enable = true;
    mysql.package = pkgs.mariadb;

    /*    nomad = {
      enable = true;
      enableDocker = true;
      dropPrivileges = false;
      extraPackages = with pkgs; [ consul cni-plugins ];
      extraSettingsPaths = [ "/home/natto/hclconfigs/nomad/nomad.json" ];
      };

      consul = {
      enable = true;
      package = pkgs.consul;
      extraConfigFiles = [ "/home/natto/hclconfigs/consul/consul.json" ];
    };*/
  };

  systemd.services = {
    tor.wantedBy = lib.mkForce [ ];
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
