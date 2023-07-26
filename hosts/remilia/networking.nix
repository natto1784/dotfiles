{ lib, config, lib', pkgs, ... }:
{
  networking = {
    useDHCP = false;
    hostName = "remilia";
    firewall =
      {
        interfaces = {
          ens3 = {
            allowedTCPPorts = [ 80 81 443 444 993 465 143 25 22 22001 22002 4444 ]
              ++ (map (x: x.sourcePort) config.networking.nat.forwardPorts);
            allowedUDPPorts = [ 17840 ];
          };
        };
        extraCommands = lib.concatMapStringsSep "\n"
          (x:
            let
              t = lib.splitString ":" x.destination;
            in
            with lib;
            "iptables -t nat -A POSTROUTING -d ${head t} -p tcp -m tcp --dport ${last t} -j MASQUERADE"
          )
          config.networking.nat.forwardPorts;
      };
    interfaces = {
      ens3 = {
        useDHCP = true;
      };
    };
    nat = with lib'.network.addresses.wireguard.ips; {
      enable = true;
      externalInterface = "ens3";
      internalInterfaces = [ "wg0" ];
      forwardPorts = [
        {
          destination = "${satori}:6600";
          sourcePort = 6600;
        }
        {
          destination = "${satori}:25565";
          sourcePort = 4444;
        }
      ];
    };
    wireguard.interfaces = with lib'.network.addresses.wireguard; {
      wg0 = {
        ips = [ ips.remilia ];
        listenPort = 17840;
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s ${ipsWithPrefixLength} -o ${config.networking.nat.externalInterface} -j MASQUERADE
        '';
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s ${ipsWithPrefixLength} -o ${config.networking.nat.externalInterface} -j MASQUERADE
        '';
        privateKeyFile = "/var/wg";
        peers = [
          {
            publicKey = "m9SSpkj+r2QY4YEUMEoTkbOI/L7C39Kh6m45QZ5mkw4=";
            allowedIPs = [ ips.marisa ];
          }
          {
            publicKey = "SqskEH7hz7Gv9ZS+FYLRFgKZyJCFbBFCyuvzBYnbfVU=";
            allowedIPs = [ ips.satori ];
          }
        ];
      };
    };
  };
}
