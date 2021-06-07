{config, pkgs, ...}:
{
  services = {
    openssh = { enable = true;
      permitRootLogin = "yes";
    };
    nginx = {
      enable = true;
      package = (pkgs.nginx.overrideAttrs(oa: {
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
            proxyPass = "http://10.55.0.2:5001";
            extraConfig = ''
              proxy_set_header Host $host;
            '';
          };
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
              {{ with secret "kv/systems/Remilia" }}{{ .Data.data.nattomail }}{{ end }}
            '';
            destination = "/var/secrets/natto@weirdnatto.in.key";
          }
        ];
      };
    };

  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJHingN2Aho+KGgEvBMjtoez+W1svl9uVoa4vG0d646j"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILCH975XCps+VCzo8Fpp5BkbtiFmj9y3//FBVYlQ7/yo"
  ];
  security.acme = {
    acceptTerms = true;
    certs = {
      "weirdnatto.in".email = "natto+acme@weirdnatto.in";    
      "git.weirdnatto.in".email = "git+acme@weirdnatto.in";    
    };
  };
  security.pki.certificateFiles = [ ../../../cert.pem ];
}
