{
  addresses = {
    wireguard = rec {
      ipPrefix = "10.55.0";
      prefixLength = 24;
      ipsWithPrefixLength = "10.55.0.0/24";
      ips = {
        remilia = "${ipPrefix}.1";
        marisa = "${ipPrefix}.2";
        satori = "${ipPrefix}.3";
      };
    };
    domain = {
      natto = "weirdnatto.in";
    };
  };
}
