{ lib, config, pkgs, ... }:
{
  networking = {
    useDHCP = false;
    hostName = "Remilia";
    firewall =
      {
        interfaces = {
          ens3 = {
            allowedTCPPorts = [
              22
              80
              81
              443
              444
              993
              465
              143
              25
              22001
              22002
              6600
              9898 
              8999
            ];
            allowedUDPPorts = [ 17840 ];
          };
        };
        extraCommands = lib.concatMapStringsSep "\n"
          (x:
            let
              t = lib.splitString ":" x.destination;
            in
            with builtins;
            "iptables -t nat -A POSTROUTING -d ${head t} -p tcp -m tcp --dport ${head (tail t)} -j MASQUERADE"
          )
          config.networking.nat.forwardPorts;
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
      forwardPorts = [
        {
          destination = "10.55.0.2:222";
          sourcePort = 22;
        }
        {
          destination = "10.55.0.3:6600";
          sourcePort = 6600;
        }
      ];
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
        privateKeyFile = "/var/wg";
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
