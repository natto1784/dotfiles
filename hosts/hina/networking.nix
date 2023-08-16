{ lib, config, lib', pkgs, ... }:
{
  networking = {
    useDHCP = false;
    hostName = "hina";
    firewall =
      {
        interfaces = {
          ens3 = {
            allowedTCPPorts = [ 9898 80 443 ];
          };
        };
      };
    interfaces = {
      ens3 = {
        useDHCP = true;
      };
    };

    wireguard.interfaces.wg0 = with lib'.network.addresses.wireguard.ips; {
      ips = [ hina ];
      listenPort = 17840;
      privateKeyFile = "/var/secrets/wg.key";
      peers = [
        {
          #Oracle VM1
          publicKey = "z0Y2VNEWcyVQVSqRHiwmiJ5/0MgSPM+HZfEcwIccSxM=";
          allowedIPs = [ remilia ];
          endpoint = "${lib'.network.addresses.domain.natto}:17840";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
