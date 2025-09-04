{
  config,
  pkgs,
  conf,
  network,
  ...
}:
{
  mailserver =
    let
      domain = conf.network.addresses.domain.natto;
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
        "natto@${domain}" = {
          hashedPasswordFile = "/var/secrets/natto@${domain}.key";
        };
        "masti@${domain}" = {
          hashedPasswordFile = "/var/secrets/masti@${domain}.key";
        };
        "chamar@${domain}" = {
          hashedPasswordFile = "/var/secrets/chamar@${domain}.key";
        };
      };
      enablePop3 = false;
      enablePop3Ssl = false;
    };
}
