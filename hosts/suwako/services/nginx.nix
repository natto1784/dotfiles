{ conf, ... }:
let
  domain = conf.network.addresses.domain.natto;
in
{
  services.nginx = {
    enable = true;
    appendHttpConfig = ''
      map $uri $expires {
        default off;
        ~\.(jpg|jpeg|png|gif|ico)$ 30d;
      }
    '';
    virtualHosts =
      let
        genericHttpRProxy =
          {
            addr,
            ssl ? true,
            conf ? "",
          }:
          {
            enableACME = ssl;
            # addSSL = ssl;
            forceSSL = ssl;
            locations."/" = {
              proxyPass = toString addr;
              extraConfig = ''
                expires $expires;
                proxy_set_header Host $host;
              ''
              + conf;
            };
          };
      in
      with conf.network.addresses.wireguard.ips;
      {
        "moj.${domain}" = genericHttpRProxy { addr = "https://${suwako}:25565"; };

        "puffer.${domain}" = genericHttpRProxy {
          addr = "http://${suwako}:8080";

          conf = ''
            proxy_set_header X-Real-IP $remote_addr;
            proxy_http_version 1.1;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Connection "Upgrade";
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header X-Nginx-Proxy true;
            proxy_set_header X-Forwarded-Proto $scheme;
            client_max_body_size 100M;
          '';
        };

        # Personal filehost
        "f.${domain}" = genericHttpRProxy { addr = "http://${suwako}:8000"; };
      };
  };
}
