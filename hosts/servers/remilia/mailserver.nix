{ config, pkgs, ... }:
{
  mailserver = {
    enable = true;
    fqdn = "mail.weirdnatto.in";
    domains = [ "weirdnatto.in" ];
    loginAccounts = {
      "natto@weirdnatto.in" = {
        hashedPasswordFile = "/var/secrets/natto@weirdnatto.in.key";
        aliases = ["@weirdnatto.in"];
      };
    };
    enablePop3 = false;
    enablePop3Ssl = false;
  };
}
