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
    mysql = {
      enable = true;
      package = pkgs.mysql;
      dataDir = "/var/db";
    };
    sshd.enable = true;
 /*   vault = {
      enable = true;
      storageBackend = "mysql";
      storagePath = "/var/db";
    };*/
  };
  systemd.services = {
    tor.wantedBy = lib.mkForce [];
    logmein-hamachi.wantedBy = lib.mkForce [];
    sshd.wantedBy = lib.mkForce [];
    mysql.wantedBy = lib.mkForce [];
    #printing.wantedBy = lib.mkForce [];
    #vault.wantedBy = lib.mkForce [];
  };
}
