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

    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };
}
