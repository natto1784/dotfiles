{lib, config, pkgs, ... }:

{
  systemd.services.nbfc = {
    description = "Notebook Fancontrol";
    wantedBy = lib.mkForce []; 
    serviceConfig = {
      Type = "forking";
      Restart = "on-failure";
      ExecStart = "${pkgs.mono}/bin/mono-service -l:/run/nbfc.pid -m:NbfcService /opt/nbfc/NbfcService.exe";
      ExecStop = "kill -SIGTERM $(cat /run/nbfc.pid)";
      PIDFile = "/run/nbfc.pid";
    };
  };  
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
  systemd.services = {
    tor.wantedBy = lib.mkForce [];
    logmein-hamachi.wantedBy = lib.mkForce [];
    openssh.wantedBy = lib.mkForce [];
    #printing.wantedBy = lib.mkForce [];
    #vault.wantedBy = lib.mkForce [];
  };
  security.pki.certificateFiles = [ ../../cert.pem ];
 /* virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemuRunAsRoot = false;
  };*/
}
