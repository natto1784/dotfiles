{ config, pkgs, lib, lib', ... }:
let
  domain = lib'.network.addresses.domain.natto;
in
{
  services = {
    cron.enable = true;
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
      ports = [ 22 22002 ];
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
          ~\.(jpg|jpeg|png|gif|ico)$ 30d;
        }
      '';
      virtualHosts =
        let
          genericHttpRProxy = { addr, ssl ? true, conf ? "" }: {
            enableACME = ssl;
            # addSSL = ssl;
            forceSSL = ssl;
            locations."/" = {
              proxyPass = toString addr;
              extraConfig = ''
                expires $expires;
                proxy_set_header Host $host;
              '' + conf;
            };
          };
        in
        with lib'.network.addresses.wireguard.ips; {
          "${domain}" = {
            addSSL = true;
            enableACME = true;
            locations."/" = {
              root = "/var/lib/site";
              index = "index.html";
            };
            serverAliases = [ "www.${domain}" ];
          };
          # "vault.${domain}" = genericHttpRProxy { addr = "https://${marisa}:8800"; };
          # "consul.${domain}" = genericHttpRProxy { addr = "http://${marisa}:8500"; };
          "f.${domain}" = genericHttpRProxy { addr = "http://${marisa}:8000"; };
          "radio.${domain}" = genericHttpRProxy { addr = "http://${satori}:8001"; };
          /* "radio.${domain}" = {
            addSSL = true;
            enableACME = true;
            locations."/" = {
            proxyPass = "http://${satori}:7590";
            extraConfig = ''
            expires $expires;
            proxy_set_header Host $host;
            '';
            };
            locations."= /".return = "301 /radio";
            };*/

          "git.${domain}" = genericHttpRProxy {
            addr = "http://${marisa}:5001";
            conf = "client_max_body_size 64M;";
          };
          /*"nomad.${domain}" = genericHttpRProxy {
            addr = "http://${marisa}:4646";
            conf = ''
            proxy_buffering off;
            proxy_read_timeout 310s;
            '';
            };
          */
        };
    };
  };

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

