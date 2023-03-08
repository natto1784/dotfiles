{ config, pkgs, lib, network, ... }:
let
  domain = network.addresses.domain.natto;
in
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
          ~\.(jpg|jpeg|png|gif|ico|css|js)$ 30d;
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
        with network.addresses.wireguard.ips; {
          "${domain}" = {
            addSSL = true;
            enableACME = true;
            locations."/" = {
              root = "/var/lib/site";
              index = "index.html";
            };
            serverAliases = [ "www.${domain}" ];
          };
          "znc.weirdnatto.in" = genericHttpRProxy { addr = "https://${marisa}:9898"; };
          "vault.${domain}" = genericHttpRProxy { addr = "https://${marisa}:8800"; };
          "consul.${domain}" = genericHttpRProxy { addr = "http://${marisa}:8500"; };
          "f.${domain}" = genericHttpRProxy { addr = "http://${marisa}:8888"; };
          "radio.${domain}" = genericHttpRProxy { addr = "http://${satori}:8001"; };
          "git.${domain}" = genericHttpRProxy {
            addr = "http://${marisa}:5000";
            conf = "client_max_body_size 64M;";
          };
          "nomad.${domain}" = genericHttpRProxy {
            addr = "http://${marisa}:4646";
            conf = ''
              proxy_buffering off;
              proxy_read_timeout 310s;
            '';
          };
          "alo.${domain}" = genericHttpRProxy {
            addr = "http://${marisa}:4004";
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
      "${domain}".extraDomainNames = lib.singleton "www.${domain}";
    } //
    lib.mapAttrs (n: _: { email = "natto@${domain}"; })
      (lib.filterAttrs (_: v: v.enableACME) config.services.nginx.virtualHosts);
  };
  security.pki.certificateFiles = [ ../../cert.pem ];
}

