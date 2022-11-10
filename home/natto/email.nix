{ config, lib, pkgs, ... }:
let
  key = "53EC089EF230E47A83BA8F8195949BD4B853F559";
  host = "mail.weirdnatto.in";
in
{
  accounts.email = {
    accounts = {
      natto = rec {
        realName = "Amneesh Singh";
        primary = true;
        address = "natto@weirdnatto.in";
        userName = address;
        gpg = {
          inherit key;
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
    };
  };
  programs = {
    mbsync.enable = true;
    neomutt = rec {
      enable = true;
      package = pkgs.neomutt;
      sort = "reverse-date";
      extraConfig =
        lib.concatMapStringsSep
          "\n"
          builtins.readFile
          [
            ./config/neomutt/neomuttrc
            ./config/neomutt/theme
          ];
    };
  };
  home = {
    packages = with pkgs; [ mailcap ];
    file = {
      mailcap = {
        source = ./config/mailcap;
        target = "${config.home.homeDirectory}/.mailcap";
      };
    };
  };
}
