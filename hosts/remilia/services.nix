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
      clientMaxBodySize = "512m";
      package = pkgs.nginx.override {
        withMail = true;
      };
      appendHttpConfig = ''
        map $uri $expires {
          default off;
          ~\.(jpg|jpeg|png|gif|ico|css|js|pdf)$ 30d;
        }
      '';
      virtualHosts =
        let
          genericHttpRProxy = { addr, ssl ? true, conf ? "" }: {
            addSSL = ssl;
            enableACME = ssl;
            locations."/" = {
              proxyPass = toString addr;
              extraConfig = ''
                expires $expires;
                proxy_set_header Host $host;
              '' + conf;
            };
          };
        in
        {
          "weirdnatto.in" = {
            addSSL = true;
            enableACME = true;
            locations."/" = {
              root = "/var/lib/site";
              index = "index.html";
            };
            serverAliases = [ "www.weirdnatto.in" ];
          };
          "vault.weirdnatto.in" = genericHttpRProxy { addr = "https://10.55.0.2:8800"; };
          "consul.weirdnatto.in" = genericHttpRProxy { addr = "http://10.55.0.2:8500"; };
          "f.weirdnatto.in" = genericHttpRProxy { addr = "http://10.55.0.2:8888"; };
          "radio.weirdnatto.in" = genericHttpRProxy { addr = "http://10.55.0.3:8001"; };
          "git.weirdnatto.in" = genericHttpRProxy {
            addr = "http://10.55.0.2:5001";
            conf = "client_max_body_size 64M;";
          };
          "nomad.weirdnatto.in" = genericHttpRProxy {
            addr = "http://10.55.0.2:4646";
            conf = ''
              proxy_buffering off;
              proxy_read_timeout 310s;
            '';
          };
          "alo.weirdnatto.in" = genericHttpRProxy {
            addr = "http://10.55.0.2:4004";
            conf = ''
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            '';
          };
        };
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJHingN2Aho+KGgEvBMjtoez+W1svl9uVoa4vG0d646j"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILCH975XCps+VCzo8Fpp5BkbtiFmj9y3//FBVYlQ7/yo"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMu+SbTrfE62nT7gkZCwiOVOlI2TkVz+RJQ49HbnHvnQ"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKFyKi0HYfkgvEDvjzmDRGwAq2z2KOkfv7scTVSnonBh"
  ];
  security.acme = {
    acceptTerms = true;
    certs = {
      "weirdnatto.in".extraDomainNames = lib.singleton "www.weirdnatto.in";
    } //
    lib.mapAttrs (n: _: { email = "natto@weirdnatto.in"; })
      (lib.filterAttrs (_: v: v.enableACME) config.services.nginx.virtualHosts);
  };
  security.pki.certificateFiles = [ ../../cert.pem ];
}

