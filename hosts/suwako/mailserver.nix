{
  conf,
  ...
}:
{
  mailserver =
    let
      domain = conf.network.addresses.domain.amneesh;
    in
    rec {
      enable = true;
      stateVersion = 3;
      fqdn = "mail.${domain}";
      sendingFqdn = fqdn;
      domains = [ domain ];
      certificateDomains = [ "mail.${domain}" ];
      certificateScheme = "acme-nginx";
      loginAccounts = {
        "me@${domain}" = {
          hashedPasswordFile = "/var/secrets/me@${domain}.key";
        };
      };
      enablePop3 = false;
      enablePop3Ssl = false;
    };
}
