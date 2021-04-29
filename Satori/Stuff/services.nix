{lib, config, pkgs, ... }:

{
  systemd.services.nbfc = {
    wantedBy = [ "multi-user.target" ]; 
    description = "Notebook Fancontrol";
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
  };
 # services.picom = {
 #   enable = true;
 #   fade = true;
 #   shadow = true;
 #   activeOpacity = 0.96;
 #   inactiveOpacity = 0.86;
 # };
}
