{ config, pkgs, lib', ... }:

{
  networking = {
    hostName = "satori";
    hostId = "beca3df0";
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };

    firewall = {
      allowedTCPPorts = [ 22 18172 6600 8001 7590 25565 ];
      allowedUDPPorts = [ 22 17840 18172 ];
      trustedInterfaces = [ "docker0" ];
    };

    wireguard.interfaces.wg0 = with lib'.network.addresses.wireguard.ips; {
      ips = [ satori ];
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

    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };
}
