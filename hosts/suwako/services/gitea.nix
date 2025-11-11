{
  conf,
  lib,
  ...
}:
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
          domain = conf.network.addresses.domain.natto;
        in
        {
          server = rec {
            HTTP_PORT = 5001;
            ROOT_URL = "https://git.${domain}";
            SSH_DOMAIN = "git.${domain}";
            SSH_PORT = 22;
            SSH_LISTEN_PORT = SSH_PORT;
          };
          mailer = rec {
            ENABLED = true;
            FROM = "masti@${domain}";
            SMTP_ADDR = "mail.${domain}";
            PROTOCOL = "smtps";
            USER = FROM;
            REGISTER_MAIL_CONFIRM = true;
          };
          service = {
            ENABLE_CAPTCHA = true;
            EMAIL_DOMAIN_ALLOWLIST = lib.strings.concatStringsSep "," [
              "gmail.com"
              "outlook.com"
              "proton.me"
              "protonmail.com"
              conf.network.addresses.domain.natto
              conf.network.addresses.domain.amneesh
              conf.network.addresses.domain.chutiya
            ];
          };
          oauth2_client.REGISTER_MAIL_CONFIRM = true;
          actions.ENABLED = false;
        };
    };
  };
}
