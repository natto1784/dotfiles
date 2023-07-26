{ config, pkgs, lib', ... }:
{
  services = {
    gitea = rec {
      appName = "Natto Tea";
      enable = true;
      database = {
        name = "gitea";
        user = "gitea";
        passwordFile = "/var/secrets/giteadb.pass";
        type = "postgres";
      };
      mailerPasswordFile = "/var/secrets/giteamailer.pass";
      settings =
        let
          domain = lib'.network.addresses.domain.natto;
        in
        {
          server = rec {
            HTTP_PORT = 5001;
            ROOT_URL = "https://git.${domain}";
            SSH_DOMAIN = "git.${domain}";
            SSH_PORT = 22001;
            SSH_LISTEN_PORT = SSH_PORT;
          };
          mailer = rec {
            ENABLED = true;
            FROM = "masti@${domain}";
            TYPE = "smtp";
            HOST = domain;
            IS_TLS_ENABLED = true;
            USER = FROM;
            REGISTER_MAIL_CONFIRM = true;
          };
          oauth2_client.REGISTER_MAIL_CONFIRM = true;
          actions.ENABLED = false;
        };
    };
  };
}

