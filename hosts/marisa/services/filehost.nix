{ config, pkgs, inputs, lib', ... }:
{
  systemd.services.filehost = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      Environment = [
        "TITLE=nattofiles"
        "USER_URL=${lib'.network.addresses.subdomain.natto "f"}"
        "ROCKET_LIMITS={file=\"512MB\",data-form=\"512MB\"}"
        "ROCKET_LOG_LEVEL=debug"
      ];
      Restart = "on-failure";
      ExecStart = "${inputs.filehost.packages.${pkgs.system}.simpler-filehost}/bin/simpler-filehost";
    };
  };
}
