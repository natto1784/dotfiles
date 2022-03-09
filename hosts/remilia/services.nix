{ config, pkgs, lib, ... }:
{
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
      ports = [ 22001 22002 ];
    };
    znc = {
      enable = true;
      mutable = true;
      useLegacyConfig = false;
    };
    nginx = {
      enable = true;
      package = (pkgs.nginx.overrideAttrs (oa: {
        configureFlags = oa.configureFlags ++ [ "--with-mail" "--with-mail_ssl_module" ];
      }));
      virtualHosts = {
        "weirdnatto.in" = {
          addSSL = true;
          enableACME = true;
          locations."/".proxyPass = "http://10.55.0.2:80";
          serverAliases = [ "www.weirdnatto.in" ];
        };
        "git.weirdnatto.in" = {
          addSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://10.55.0.2:5000";
            extraConfig = ''
              client_max_body_size 64M;
              proxy_set_header Host $host;
            '';
          };
        };
        "vault.weirdnatto.in" = {
          addSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "https://10.55.0.2:8800";
            extraConfig = ''
              proxy_set_header Host $host;
            '';
          };
        };
        "consul.weirdnatto.in" = {
          addSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://10.55.0.2:8500";
            extraConfig = ''
              proxy_set_header Host $host;
            '';
          };
        };
        "nomad.weirdnatto.in" = {
          addSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://10.55.0.2:4646";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_buffering off;
              proxy_read_timeout 310s;
            '';
          };
        };
        "radio.weirdnatto.in" = {
          addSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://10.55.0.3:8000";
            extraConfig = ''
              proxy_set_header Host $host;
            '';
          };
        };
        "ci.weirdnatto.in" = {
          addSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://10.55.0.2:6666";
            extraConfig = ''
              proxy_set_header Host $host;
            '';
          };
        };
      };
      /*streamConfig = ''
        upstream gitea {
        server 10.55.0.2:222;
        }
        server {
        listen 22001;
        proxy_pass gitea;
        }
        '';*/
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
                name = "Remilia";
              };
            }
          ];
        };
        template = [
          {
            source = pkgs.writeText "wg.tpl" ''
              {{ with secret "kv/systems/Remilia/wg" }}{{ .Data.data.private }}{{ end }}
            '';
            destination = "/var/secrets/wg.key";
          }
          {
            source = pkgs.writeText "natto@weirdnatto.in.tpl" ''
              {{ with secret "kv/systems/Remilia/mail" }}{{ .Data.data.nattomail }}{{ end }}
            '';
            destination = "/var/secrets/natto@weirdnatto.in.key";
          }
          {
            source = pkgs.writeText "masti@weirdnatto.in.tpl" ''
              {{ with secret "kv/systems/Remilia/mail" }}{{ .Data.data.mastimail }}{{ end }}
            '';
            destination = "/var/secrets/masti@weirdnatto.in.key";
          }
        ];
      };
    };

  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJHingN2Aho+KGgEvBMjtoez+W1svl9uVoa4vG0d646j"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILCH975XCps+VCzo8Fpp5BkbtiFmj9y3//FBVYlQ7/yo"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK0jyHWuWBKzucnARINqQ/A0AFPghxayh0DDthbpOhaz"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKFyKi0HYfkgvEDvjzmDRGwAq2z2KOkfv7scTVSnonBh"
  ];
  security.acme = {
    acceptTerms = true;
    certs = {
      "weirdnatto.in".extraDomainNames = lib.singleton "www.weirdnatto.in";
    } //
    lib.mapAttrs' (n: _: lib.nameValuePair n ({ email = "natto@weirdnatto.in"; })) config.services.nginx.virtualHosts;
  };
  security.pki.certificateFiles = [ ../../cert.pem ];
}
