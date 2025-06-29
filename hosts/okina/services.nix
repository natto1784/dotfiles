{
  lib,
  config,
  pkgs,
  ...
}:
{
  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
    };
    ratbagd.enable = true;
    btrfs.autoScrub.enable = true;
    gvfs.enable = true;
    logind.extraConfig = "RuntimeDirectorySize=30%";
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };
    avahi = lib.mkIf config.services.printing.enable {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  systemd.services = {
    libvirtd.wantedBy = lib.mkForce [ ];
  };

  virtualisation = {
    docker = {
      enable = true;
    };
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu.runAsRoot = true;
    };
  };
}
