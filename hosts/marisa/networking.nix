{ config, pkgs, ... }:
{
  networking = {
    hostName = "marisa";
    firewall = {
      allowedTCPPorts = [
        22 # ssh
        80 # http
        6060
        4444
        5454
        8080 #????
        5001 #gitea
        8800
        4646
        8500 #vault nomad consul
        8888 #simpler-filehost1
        6666 #concourse
        202 #gitea-ssh
      ];
      allowedUDPPorts = [ 17840 ];
      trustedInterfaces = [ "docker0" ];
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
