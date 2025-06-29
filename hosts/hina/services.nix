{
  config,
  pkgs,
  lib,
  conf,
  ...
}:
let
  domain = conf.network.addresses.domain.natto;
in
{
  services = {
    cron.enable = true;

    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
      ports = [ 22 ];
    };

    znc = {
      enable = true;
      mutable = true;
      useLegacyConfig = false;
    };

    nginx = {
      enable = true;
      virtualHosts = with conf.network.addresses.wireguard.ips; {
        "znc.${domain}" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "https://${hina}:9898";
          };
        };
      };
    };
  };
}
