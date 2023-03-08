{ config, pkgs, lib', network, ... }:
{
  mailserver =
    let domain = lib'.network.addresses.domain.natto; in
    rec {
      enable = true;
      fqdn = "mail.${domain}";
      sendingFqdn = fqdn;
      domains = [ domain ];
      certificateDomains = [ "mail.${domain}" ];
      certificateScheme = 3;
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
