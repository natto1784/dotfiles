{lib, config, pkgs, ... }:

{
  networking = {
    hostName = "nixchod";
    wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    useDHCP = false;
    interfaces = {
      enp7s0.useDHCP = true;
      wlp0s20f3.useDHCP = true;
    };
  };
}
