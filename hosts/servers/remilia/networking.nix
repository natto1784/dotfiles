{config, pkgs, ...}:
{
  networking = {
    useDHCP = false;
    hostName = "Remilia";
    firewall = {
      interfaces = {
        ens3 = {
          allowedTCPPorts = [ 22 80 443 ];
          allowedUDPPorts = [ 17840 ];
        };
      };
    };
    interfaces = {
      ens3 = {
        useDHCP = true;
      };
    };
    nat = {
      enable = true;
      externalInterface = "ens3";
      internalInterfaces = [ "wg0" ];
    };
    wireguard.interfaces = {
      wg0 = {
        ips = [ "10.55.0.1/24" ];
        listenPort = 17840;
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.55.0.0/24 -o ${config.networking.nat.externalInterface} -j MASQUERADE
        '';
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.55.0.0/24 -o ${config.networking.nat.externalInterface} -j MASQUERADE
        '';
        privateKeyFile = "/var/secrets/wg";
        peers = [
          {
            publicKey = "m9SSpkj+r2QY4YEUMEoTkbOI/L7C39Kh6m45QZ5mkw4=";
            allowedIPs = [ "10.55.0.2/32" ];
          }
          {
            publicKey = "SqskEH7hz7Gv9ZS+FYLRFgKZyJCFbBFCyuvzBYnbfVU=";
            allowedIPs = [ "10.55.0.3/32" ];
          }
        ];
      };
    };
  };
}
