{ config, pkgs, lib, lib', ... }:
let
  domain = lib'.network.addresses.domain.natto;
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
      virtualHosts = with lib'.network.addresses.wireguard.ips; {
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

  security.acme = {
    acceptTerms = true;
    certs = lib.mapAttrs (n: _: { email = "natto@${domain}"; })
      (lib.filterAttrs (_: v: v.enableACME) config.services.nginx.virtualHosts);
  };
  security.pki.certificateFiles = [ ../../cert.pem ];
}

