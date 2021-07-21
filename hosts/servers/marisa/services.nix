{lib, config, pkgs, ...}:
{
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
    vault = {
      package = pkgs.vault-bin;
      enable = true;
      tlsCertFile = "/var/certs/cert.pem";
      tlsKeyFile = "/var/certs/key.pem";
      address = "0.0.0.0:8800";
      extraSettingsPaths = [ /var/vault/vault.hcl ];
      storageBackend = "postgresql";
      extraConfig = ''
        api_addr = "https://127.0.0.1:8800"
        ui = true
      '';
    };
    vault-agent = {
      enable = true;
      settings = {
        vault = {
          address = "https://10.55.0.2:8800";
          client_cert = "/var/vault/cert.pem";
          client_key = "/var/vault/key.pem";
        };
        auto_auth = {
          method = [
            {
              "cert" = {
                name = "Marisa";
              };
            }
          ];
        };
        template = [
          {
            source = pkgs.writeText "gitea.tpl" ''
              {{ with secret "kv/systems/Marisa/gitea" }}{{ .Data.data.gitea }}{{ end }}
            '';
            destination = "/var/secrets/gitea.key";
          }
          {
            source = pkgs.writeText "wg.tpl" ''
              {{ with secret "kv/systems/Marisa/wg" }}{{ .Data.data.private }}{{ end }}
            '';
            destination = "/var/secrets/wg.key";
          }
        ];
      };
    };
    postgresql = {
      enable = true;
      port = 6060;
      enableTCPIP = true;
      authentication = ''
        local gitea all ident map=gitea-map
        host vault all 10.55.0.2/32 md5
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
        passwordFile = "/var/secrets/gitea.key";
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
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK06ZUa9BKmZ6m+xapBjOAm10OCLzxIm8ais20wQC47m"
  ];
  security.pki.certificateFiles = [ ../../../cert.pem ];
}
