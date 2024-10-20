{ config, pkgs, lib, conf, ... }:
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
  };

  security.acme = {
    acceptTerms = true;
    certs = lib.mapAttrs (n: _: { email = "natto@${domain}"; })
      (lib.filterAttrs (_: v: v.enableACME) config.services.nginx.virtualHosts);
  };

  security.pki.certificateFiles = [ ../../cert.pem ];
}

