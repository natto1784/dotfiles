{ conf, ... }:
let
  domain = conf.network.addresses.domain.natto;
in
{
  services.nginx = {
    enable = true;
    virtualHosts = with conf.network.addresses.wireguard.ips; {
      "moj.${domain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "https://${suwako}:25565";
        };
      };
      "puffer.${domain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://${suwako}:8080";
        };
        extraConfig = ''
          proxy_set_header X-Real-IP $remote_addr;
          proxy_http_version 1.1;
          proxy_set_header Host $host;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header Connection "Upgrade";
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header X-Nginx-Proxy true;
          proxy_set_header X-Forwarded-Proto $scheme;
          client_max_body_size 100M;
        '';
      };
    };
  };
}
