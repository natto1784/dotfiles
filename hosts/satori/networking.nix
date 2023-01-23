{ config, pkgs, ... }:

{
  networking = {
    hostName = "satori";
    hostId = "beca3df0";
    defaultGateway = "192.168.1.1";
    networkmanager.enable = true;
    wireless.interfaces = [ "wlp0s20f3" ];
    firewall = {
      allowedTCPPorts = [ 22 18172 6600 8001 25565 ];
      allowedUDPPorts = [ 22 17840 18172 ];
      trustedInterfaces = [ "docker0" ];
    };
    interfaces = {
      enp7s0 = {
        useDHCP = true;
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
  };
}
