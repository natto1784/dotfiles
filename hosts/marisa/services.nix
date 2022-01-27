{ lib, config, pkgs, ... }:
{

  # Add secrets to conul and nomad configs
  systemd.services.consul.preStart =
    let
      originalCfg = pkgs.writeText "consulConfiguration.json" (builtins.toJSON rec {
        data_dir = "/var/lib/consul";
        ui_config = {
          enabled = true;
        };
        bootstrap = true;
        log_level = "DEBUG";
        enable_syslog = true;
        datacenter = "dc1";
        bind_addr = "10.55.0.2";
        client_addr = bind_addr;
        primary_datacenter = "dc1";
        node_name = "Marisa";
        acl = {
          enabled = true;
          default_policy = "deny";
          tokens = {
            agent = "+++consul_marisa+++";
          };
        };
        server = true;
        connect = {
          enabled = true;
        };
        ports = {
          grpc = 8502;
        };
        encrypt = "+++consul_encryption+++";
        ca_file = "/var/consul-certs/consul-agent-ca.pem";
        cert_file = "/var/consul-certs/dc1-server-consul-0.pem";
        key_file = "/var/consul-certs/dc1-server-consul-0-key.pem";
      });
    in
    lib.mkForce ''
      mkdir -p /run/consul
      sed -e 's,+++consul_encryption+++,'"$(cat /var/secrets/consul_encryption.key)"',' \
          -e 's,+++consul_marisa+++,'"$(cat /var/secrets/consul_marisa.token)"',' \
             ${originalCfg} > /run/consul/consul.json
    '';

  systemd.services.nomad.after = [ "consul.service" ];
  systemd.services.nomad.preStart =
    let
      originalCfg = pkgs.writeText "nomadConfiguration.json"
        (builtins.toJSON rec {
          bind_addr = "0.0.0.0";
          data_dir = "/var/lib/nomad";
          disable_update_check = true;
          datacenter = "n1";
          log_file = "/var/log/nomad/nomad.log";
          server = {
            enabled = true;
            encrypt = "+++nomad_encryption+++";
          };
          plugin."docker" = {
            config = {
              allow_privileged = true;
              volumes.enabled = true;
              pull_activity_timeout = "30m";
            };
          };
          client = {
            options = {
              "docker.privileged.enabled" = true;
              "docker.volumes.enabled" = true;
            };
            enabled = true;
            cni_path = "${pkgs.cni-plugins}/bin";
          };
          vault = {
            enabled = true;
            token = "+++nomad_vault+++";
            address = "https://10.55.0.2:8800";
            ca_file = "/var/rootcert/cert.pem";
            cert_file = "/var/certs/cert.pem";
            key_file = "/var/certs/key.pem";
            allow_unauthenticated = false;
            create_from_role = "nomad-cluster";
          };
          consul = {
            address = "10.55.0.2:8500";
            token = "+++nomad_consul+++";
            ssl = false;
            allow_unauthenticated = false;
            ca_file = "/var/consul-certs/consul-agent-ca.pem";
            cert_file = "/var/consul-certs/dc1-server-consul-0.pem";
            key_file = "/var/consul-certs/dc1-server-consul-0-key.pem";
            auto_advertise = true;
            server_auto_join = true;
            client_auto_join = true;
          };
          acl = {
            enabled = true;
          };
        });
    in
    ''
      mkdir -p /run/nomad
      sed -e 's,+++nomad_encryption+++,'"$(cat /var/secrets/nomad_encryption.key)"',' \
          -e 's,+++nomad_consul+++,'"$(cat /var/secrets/nomad_consul.token)"',' \
          -e 's,+++nomad_vault+++,'"$(cat /var/secrets/nomad_vault.token)"',' \
             ${originalCfg} > /run/nomad/nomad.json
    '';
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
    nomad = {
      package = pkgs.master.nomad;
      enable = true;
      enableDocker = true;
      dropPrivileges = false;
      extraPackages = with pkgs; [ consul ];
      extraSettingsPaths = lib.singleton "/run/nomad/nomad.json";
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
      enable = true;
      package = pkgs.master.consul;
      extraConfigFiles = lib.singleton "/run/consul/consul.json";
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
          {
            source = pkgs.writeText "consul_marisa.tpl" ''
              {{ with secret "kv/systems/Marisa/consul" }}{{ .Data.data.agentToken }}{{ end }}
            '';
            destination = "/var/secrets/consul_marisa.token";
          }
          {
            source = pkgs.writeText "consul_bootstrap.tpl" ''
              {{ with secret "kv/consul" }}{{ .Data.data.bootstrapToken }}{{ end }}
            '';
            destination = "/var/secrets/consul_bootstrap.token";
          }
          {
            source = pkgs.writeText "consul_encryption.tpl" ''
              {{ with secret "kv/consul" }}{{ .Data.data.encryptionKey }}{{ end }}
            '';
            destination = "/var/secrets/consul_encryption.key";
          }
          {
            source = pkgs.writeText "nomad_vault.tpl" ''
              {{ with secret "kv/nomad" }}{{ .Data.data.vaultToken }}{{ end }}
            '';
            destination = "/var/secrets/nomad_vault.token";
          }
          {
            source = pkgs.writeText "nomad_vault.tpl" ''
              {{ with secret "kv/nomad" }}{{ .Data.data.consulToken }}{{ end }}
            '';
            destination = "/var/secrets/nomad_consul.token";
          }
          {
            source = pkgs.writeText "nomad_encryption.tpl" ''
              {{ with secret "kv/nomad" }}{{ .Data.data.encryptionKey }}{{ end }}
            '';
            destination = "/var/secrets/nomad_encryption.key";
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
      enable = false;
      appName = "Natto Tea";
      rootUrl = "https://git.weirdnatto.in/";
      cookieSecure = true;
      dump = {
        enable = true;
        backupDir = "/tmp/gitea";
        type = "tar.gz";
        file = "gitnigger";
      };
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
  security.pki.certificateFiles = [ ../../cert.pem ../../consul-agent-ca.pem ];

}

