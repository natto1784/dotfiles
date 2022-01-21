{ lib, config, pkgs, ... }:
{
  systemd.services.nomad.after = [ "consul.service" ];
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
    nomad = {
      enable = false;
      enableDocker = true;
      settings = {
        bind_addr = "0.0.0.0";
        data_dir = "/var/lib/nomad";
        datacenter = "n1";
        log_file = "/var/log/nomad/nomad.log";
        server = {
          enabled = true;
          bootstrap_expect = 1;
          encrypt = "nY1vuN+1ecJkwJu0s2x6Ge6UX/txvTxVqNrDMqruMlg=";
        };
        client = {
          enabled = true;
        };
        vault = {
          enabled = true;
          token = "s.WaNfk6ZISRbwsEx43UokG3HU";
          address = "https://10.55.0.2:8800";
          ca_file = "/var/rootcert/cert.pem";
          cert_file = "/var/vault/cert.pem";
          key_file = "/var/vault/key.pem";
          allow_unauthenticated = false;
          create_from_role = "nomad-cluster";
        };
        consul = {
          address = "10.55.0.2:4444";
          ssl = true;
          allow_unauthenticated = false;
          auto_advertise = true;
          server_auto_join = true;
          client_auto_join = true;
          ca_file = "/var/certs/cert.pem";
          cert_file = "/var/vault/cert.pem";
          key_file = "/var/vault/key.pem";
        };
        acl = {
          enabled = true;
        };
      };
    };
    vault = {
      package = pkgs.vault-bin;
      enable = true;
      tlsCertFile = "/var/rootcert/cert.pem";
      tlsKeyFile = "/var/rootcert/key.pem";
      address = "0.0.0.0:8800";
      storageBackend = "file";
      storagePath = "/var/lib/vault";
      extraConfig = ''
        api_addr = "https://127.0.0.1:8800"
        ui = true
      '';
    };
    consul = {
      enable = false;
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
        encrypt = "dXoYbVt1Rb1cTFTWVBGO6CaFIBmc90MPCjhqttBlXi0=";
        ca_file = "/var/rootcert/cert.pem";
        cert_file = "/var/certs/cert.pem";
        key_file = "/var/certs/key.pem";
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
          client_cert = "/var/certs/cert.pem";
          client_key = "/var/certs/key.pem";
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
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJHingN2Aho+KGgEvBMjtoez+W1svl9uVoa4vG0d646j"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPX1HDzWpoaOcU8GDEGuDzXgxkCpyeqxRR6gLs/8JgHw"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOSQnDNrNP69tIK7U2D7qaMjycfIjpgx0at4U2D5Ufib"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK5V/hdkTTQSkDLXaEwY8xb/T8+sWtw5c6UjYOPaTrO8"
  ];
  security.pki.certificateFiles = [ ../../cert.pem ];
}
