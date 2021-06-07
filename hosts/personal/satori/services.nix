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
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
    vault-agent = {
      enable = true;
      settings = {
        vault = {
          address = "https://10.55.0.2:8800";
          client_cert = "/var/vault/cert.pem";
          client_key = "/var/vault/key.pem";
        };
        auto_auth = {
          method = [
            {
              "cert" = {
                name = "Satori";
              };
            }
          ];
        };
        template = [
          {
            source = pkgs.writeText "wg.tpl" ''
              {{ with secret "kv/systems/Satori/wg" }}{{ .Data.data.private }}{{ end }}
            '';
            destination = "/var/secrets/wg.key";
          }
        ];
      };
    };

  };
  systemd.services = {
    tor.wantedBy = lib.mkForce [];
    logmein-hamachi.wantedBy = lib.mkForce [];
    openssh.wantedBy = lib.mkForce [];
    mysql.wantedBy = lib.mkForce [];
    #printing.wantedBy = lib.mkForce [];
    #vault.wantedBy = lib.mkForce [];
  };
  security.pki.certificateFiles = [ ../../../cert.pem ];
}
