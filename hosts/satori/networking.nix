{ config, pkgs, ... }:

{
  networking = {
    hostName = "Satori";
    wireless.enable = true;
    wireless.interfaces = [ "wlp0s20f3" ];
    firewall = {
      allowedTCPPorts = [ 22 18172 6600 8001 ];
      allowedUDPPorts = [ 22 17840 18172 ];
    };
    interfaces = {
      enp7s0 = {
        useDHCP = true;
        ipv4.addresses = [{
          prefixLength = 24;
          address = "192.168.0.109";
        }];
      };
      wlp0s20f3 = {
        useDHCP = true;
        ipv4.addresses = [{
          prefixLength = 24;
          address = "192.168.0.109";
        }];
      };
    };
    wireguard.interfaces.wg0 = {
      ips = [ "10.55.0.3/32" ];
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
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };
}
