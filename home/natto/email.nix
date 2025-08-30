{
  config,
  lib,
  pkgs,
  inputs,
  conf,
  ...
}:
let
  realName = "Amneesh Singh";
in
{
  accounts.email = {
    accounts = {
      natto =
        let
          domain = conf.network.addresses.domain.natto;
          address = "natto@${domain}";
          host = "mail.${domain}";
        in
        {
          inherit realName address;
          primary = true;
          userName = address;
          gpg = {
            key = "3C4BDBE7BBF45B52C14EA193007257B05FCC86A8";
            signByDefault = true;
          };
          imap = {
            inherit host;
            tls.enable = true;
          };
          imapnotify.enable = true;
          smtp = {
            inherit host;
            tls.enable = true;
          };
          mbsync = {
            enable = true;
            create = "both";
          };
          passwordCommand = "pass show email/${address}";
          neomutt = {
            enable = true;
            extraMailboxes = [
              "Sent"
              "Drafts"
              "Trash"
              "Junk"
            ];
          };
        };

      amneesh =
        let
          domain = conf.network.addresses.domain.amneesh;
          address = "me@${domain}";
          host = "mail.${domain}";
        in
        {
          inherit address realName;
          userName = address;

          gpg = {
            key = "0C2FDA374F2D48D9F9F0F7788EAAB36980C424C2";
            signByDefault = true;
          };

          imap = {
            inherit host;
            tls.enable = true;
          };
          imapnotify.enable = true;
          smtp = {
            inherit host;
            tls.enable = true;
          };
          mbsync = {
            enable = true;
            create = "both";
          };
          passwordCommand = "pass show email/${address}";
          neomutt = {
            enable = true;
            extraMailboxes = [
              "Sent"
              "Drafts"
              "Junk"
            ];
          };
        };
    };
  };
  services = {
    imapnotify.enable = true;
  };
  programs = {
    mbsync.enable = true;
    neomutt = rec {
      enable = true;
      package = pkgs.neomutt;
      sort = "reverse-date";
      extraConfig = lib.concatMapStringsSep "\n" builtins.readFile [
        ./config/neomutt/neomuttrc
        ./config/neomutt/theme
      ];
    };
  };
  home = {
    packages = with pkgs; [
      mailcap
      w3m
    ];
    file = {
      mailcap = {
        source = ./config/mailcap;
        target = "${config.home.homeDirectory}/.mailcap";
      };
    };
  };
}
