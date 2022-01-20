{ lib, config, pkgs, ... }:
{
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
 /*   nomad = {
      enable = true;
      enableDocker = true;
      settings = {
        data_dir = "/var/lib/nomad";
        server = {
          enable = true;
          bootstrap_expect = 1;
        };
        vault = {
          enabled = true;
          address = "https://10.55.0.2:6060";
          ca_path = "../../cert.pem";
          cert_file = "/var/vault/cert.pem";
          key_file = "/var/vault/key.pem";
#          allow_unauthenticated = true;
          create_from_role = "nomad-cluster";
        };

      };
    };*/
    vault = {
      package = pkgs.vault-bin;
      enable = true;
      tlsCertFile = "/var/certs/cert.pem";
      tlsKeyFile = "/var/certs/key.pem";
      address = "0.0.0.0:8800";
      storageBackend = "file";
      storagePath = "/var/lib/vault";
      extraConfig = ''
        api_addr = "https://127.0.0.1:8800"
        ui = true
      '';
    };
    consul = {
      enable = true;
      webUi = true;
      extraConfig = rec {
        bootstrap = true;
        log_level = "DEBUG";
        enable_syslog = true;
        datacenter = "d1";
        bind_addr = "10.55.0.2";
        client_addr = bind_addr;
        primary_datacenter = "d1";
        node_name = "Marisa";
        server = true;
        connect = {
          enabled = true;
        };
        encrypt = "zdlcIl2Z4D01SdNQMv6fSfBN6OkQU10LAyPvwdQDwn4=";
        ca_file = "../../cert.pem";
        ports = {
          http = 4444;
          grpc = 4445;
        };
      };
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
         UPDATE_AVATAR = true;
        };
        ui = {
          DEFAULT_THEME = "arc-green";
        };
        security = {
          LOGIN_REMEMBER_DAYS = 50;
        };
        server = {
          SSH_PORT = lib.mkForce 22001;
        };
      };
    };
  };
  #  systemd.services.consul.serviceConfig.Type = "notify";
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJHingN2Aho+KGgEvBMjtoez+W1svl9uVoa4vG0d646j"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPX1HDzWpoaOcU8GDEGuDzXgxkCpyeqxRR6gLs/8JgHw"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOSQnDNrNP69tIK7U2D7qaMjycfIjpgx0at4U2D5Ufib"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK5V/hdkTTQSkDLXaEwY8xb/T8+sWtw5c6UjYOPaTrO8"
  ];
  security.pki.certificateFiles = [ ../../cert.pem ];
}
