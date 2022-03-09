{ config, pkgs, lib, ... }:
{
  mailserver = with lib; rec {
    enable = true;
    fqdn = "mail.weirdnatto.in";
    sendingFqdn = fqdn;
    domains = singleton "weirdnatto.in";
    certificateDomains = singleton "mail.weirdnatto.in";
    certificateScheme = 2;
    loginAccounts = {
      "natto@weirdnatto.in" = {
        hashedPasswordFile = "/var/secrets/natto@weirdnatto.in.key";
        aliases = [ "@weirdnatto.in" ];
      };
      "masti@weirdnatto.in" = {
        hashedPasswordFile = "/var/secrets/masti@weirdnatto.in.key";
        aliases = [ "@weirdnatto.in" ];
      };
    };
    enablePop3 = false;
    enablePop3Ssl = false;
  };
}
