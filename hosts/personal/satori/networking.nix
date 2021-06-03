{config, pkgs, ... }:

{
  networking = {
    hostName = "Satori";
    wireless.enable = true;
    firewall = {
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ 17840 ];
    };
    interfaces = {
      enp7s0.useDHCP = true;
      wlp0s20f3 = {
        useDHCP = true;
        ipv4.addresses = [ {
          prefixLength = 24;
          address = "192.168.0.109";
        } ];
      };
    };
    wireguard.interfaces.wg0 = {
      ips = [ "10.55.0.3/32" ];
      listenPort = 17840;
      privateKeyFile = "/var/secrets/wg";
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
