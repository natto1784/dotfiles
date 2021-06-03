{lib, config, pkgs, ...}:
{
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
    dovecot2 = {
      enable = true;
      enableImap = true;
    };
 /*   vault = {
      enable = true;
      address = "127.0.0.1:8000";
      storageBackend = "postgresql";
    };*/
    postgresql = {
      enable = true;
      port = 6060;
      enableTCPIP = true;
      authentication = ''
        local gitea all ident map=gitea-map
        host all all 192.168.0.110/32 md5
        '';
      identMap = ''
        gitea-map gitea gitea
        '';
    };
    gitea = {
      enable = true;
      appName = "Natto Tea";
      rootUrl = "https://git.weirdnatto.in/";
      cookieSecure = true;
      httpPort = 5001;
      database = rec {
        createDatabase = false;
        port = 6060;
        name = "gitea";
        user = name;
        passwordFile = "/var/secrets/gitea";
        type = "postgres";
      };
      settings = {
        oauth2_client = {
          ENABLE_AUTO_REGISTRATION = true;
          UPDATE_AVATAR = true;
        };
        ui = {
          DEFAULT_THEME="arc-green";
        };
        security = {
          LOGIN_REMEMBER_DAYS = 50;
        };
      };
    };
  };
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJHingN2Aho+KGgEvBMjtoez+W1svl9uVoa4vG0d646j"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPX1HDzWpoaOcU8GDEGuDzXgxkCpyeqxRR6gLs/8JgHw"
  ];
}
