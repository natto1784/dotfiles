{config, ...}:
{
  networking = {
    useDHCP = false;
    hostName = "Remilia";
    firewall.allowedTCPPorts = [ 22 80 ];
    interfaces = {
      ens3 = {
        useDHCP = true;
      };
    };
  };
}
