{
  conf,
  pkgs,
  ...
}:
{
  services = {
    forgejo = {
      enable = true;

      package = pkgs.forgejo;
      database = {
        name = "forgejo";
        user = "forgejo";
        passwordFile = "/var/secrets/forgejodb.pass";
        type = "postgres";
      };
      secrets.mailer.PASSWD = "/var/secrets/forgejomailer.pass";
      settings =
        let
          domain = conf.network.addresses.domain.natto;
        in
        {
          DEFAULT.APP_NAME = "Natto Forge";
          oauth2_client.REGISTER_MAIL_CONFIRM = true;
          actions.ENABLED = false;

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
            DISABLE_REGISTRATION = false;
            USER_REGISTRATION_MODE = "manual";
            REGISTER_EMAIL_CONFIRM = true;
            REQUIRE_SIGNIN_VIEW = "expensive";
          };
        };
    };
  };
}
