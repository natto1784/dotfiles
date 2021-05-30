{config,  ... }:

{
  networking = {
    hostName = "Satori";
    wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    firewall.allowedTCPPorts = [ 22 ];
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
    defaultGateway = "192.168.0.1";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };
}
