{config, ...}:
{
  networking = {
    hostName = "Marisa";
    wireless.enable = false;
    wireless.iwd.enable = true;
    interfaces = {
      wlan0 = {
        useDHCP = false;
        ipv4.addresses = [ {
          prefixLength = 24;
          address = "192.168.0.159";
        } ];
      };
    };
    defaultGateway = "192.168.0.1";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };
}
