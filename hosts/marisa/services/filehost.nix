{ config, pkgs, inputs, conf, ... }:
{
  systemd.services.filehost = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      Environment = [
        "TITLE=nattofiles"
        "USER_URL=https://f.${conf.network.addresses.domain.natto}"
        "ROCKET_LIMITS={file=\"512MB\",data-form=\"512MB\"}"
        "ROCKET_LOG_LEVEL=debug"
        "ROCKET_ADDRESS=0.0.0.0"
      ];
      Restart = "on-failure";
      ExecStart = "${inputs.filehost.packages.${pkgs.system}.simpler-filehost}/bin/simpler-filehost";
    };
  };
}
