{ lib, config, conf, pkgs, ... }:
{
  networking = {
    useDHCP = false;
    hostName = "suwako";
    firewall =
      {
        interfaces = {
          enp0s6 = {
            allowedTCPPorts = [ 22 443 80 ];
          };
        };
      };
    interfaces = {
      enp0s6 = {
        useDHCP = true;
      };
    };

    wireguard.interfaces.wg0 = with conf.network.addresses.wireguard.ips; {
      ips = [ suwako ];
      listenPort = 17840;
      privateKeyFile = "/var/secrets/wg.key";
      peers = [
        {
          #Oracle VM1
          publicKey = "z0Y2VNEWcyVQVSqRHiwmiJ5/0MgSPM+HZfEcwIccSxM=";
          allowedIPs = [ remilia ];
          endpoint = "${conf.network.addresses.domain.natto}:17840";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
