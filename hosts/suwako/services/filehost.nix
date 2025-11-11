{
  lib,
  pkgs,
  inputs,
  conf,
  ...
}:
{
  systemd.services = rec {
    filehost = {
      enable = true;
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        Environment = [
          "TITLE=nattofiles"
          "INTERNAL_HOST=0.0.0.0"
          "INTERNAL_PORT=8000"
          "MAX_FILESIZE_MB=500"
          "EXTERNAL_HAS_TLS=1"
          "EXTERNAL_HOST=f.${conf.network.addresses.domain.natto}"
        ];
        Restart = "on-failure";
        ExecStart = "${inputs.filehost.packages.${pkgs.system}.yamaf}/bin/yamaf";
      };
    };

    filehost-chutiya = lib.recursiveUpdate filehost {
      serviceConfig.Environment = [
          "TITLE=chutiyafiles"
          "INTERNAL_HOST=0.0.0.0"
          "INTERNAL_PORT=8001"
          "MAX_FILESIZE_MB=500"
          "EXTERNAL_HAS_TLS=1"
          "EXTERNAL_HOST=f.${conf.network.addresses.domain.chutiya}"
        ];
      };
    };
}
