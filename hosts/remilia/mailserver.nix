{ config, pkgs, lib, ... }:
{
  mailserver = with lib; rec {
    enable = true;
    fqdn = "mail.weirdnatto.in";
    sendingFqdn = fqdn;
    domains = singleton "weirdnatto.in";
    certificateDomains = singleton "mail.weirdnatto.in";
    certificateScheme = 3;
    loginAccounts = {
      "natto@weirdnatto.in" = {
        hashedPasswordFile = "/var/secrets/natto@weirdnatto.in.key";
      };
      "masti@weirdnatto.in" = {
        hashedPasswordFile = "/var/secrets/masti@weirdnatto.in.key";
      };
    };
    enablePop3 = false;
    enablePop3Ssl = false;
  };
}
