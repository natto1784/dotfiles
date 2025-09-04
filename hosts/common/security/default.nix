{
  lib,
  conf,
  config,
  ...
}:
let
  domain = conf.network.addresses.domain.natto;
  nginx = config.services.nginx;
in
{
  security = {
    acme = lib.mkIf nginx.enable {
      acceptTerms = true;
      certs = lib.mapAttrs (n: _: { email = "natto@${domain}"; }) (
        lib.filterAttrs (_: v: v.enableACME) nginx.virtualHosts
      );
    };
    pki.certificateFiles = [ ../../../cert.pem ];
  };
}
