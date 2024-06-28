{ config, pkgs, conf, lib, ... }:

{
  networking = {
    hostName = "okina";
    hostId = "fa6f8f15";

    networkmanager = {
      enable = true;
    };

    firewall = {
      allowedTCPPorts = [ 22 18172 6600 8001 7590 25565 9092 8096 ];
      allowedUDPPorts = [ 22 17840 18172 ];
      trustedInterfaces = [ "docker0" ];
    };

    interfaces = {
      enp7s0 = {
        ipv4.addresses = [{
          prefixLength = 24;
          address = "192.168.1.106";
        }];
      };
    };

    wireguard.interfaces.wg0 = with conf.network.addresses.wireguard.ips; {
      ips = [ okina ];
      listenPort = 17840;
      privateKeyFile = "/var/secrets/wg.key";
      peers = [{
        #Oracle VM1
        publicKey = "z0Y2VNEWcyVQVSqRHiwmiJ5/0MgSPM+HZfEcwIccSxM=";
        allowedIPs = [ remilia ];
        endpoint = "${conf.network.addresses.domain.natto}:17840";
        persistentKeepalive = 25;
      }];
    };


    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };
}
