{ config, pkgs, ... }:
{
  networking = {
    hostName = "marisa";
    firewall = {
      allowedTCPPorts = [ 22 80 6060 5001 8800 6666 4444 4646 8500 202 5454 8080 ];
      allowedUDPPorts = [ 17840 ];
    };

    wireless = {
      enable = false;
      iwd.enable = true;
    };
    interfaces = {
      eth0 = {
        useDHCP = false;
        ipv4.addresses = [{
          prefixLength = 24;
          address = "192.168.1.159";
        }];
      };
      wlan0 = {
        useDHCP = false;
        ipv4.addresses = [{
          prefixLength = 24;
          address = "192.168.1.159";
        }];
      };
    };
    wireguard.interfaces.wg0 = {
      ips = [ "10.55.0.2/24" ];
      listenPort = 17840;
      privateKeyFile = "/var/secrets/wg.key";
      peers = [
        {
          #Oracle VM1
          publicKey = "z0Y2VNEWcyVQVSqRHiwmiJ5/0MgSPM+HZfEcwIccSxM=";
          allowedIPs = [ "10.55.0.0/24" ];
          endpoint = "weirdnatto.in:17840";
          persistentKeepalive = 25;
        }
      ];
    };
    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };
}
