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

  commonSSHKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJHingN2Aho+KGgEvBMjtoez+W1svl9uVoa4vG0d646j"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPX1HDzWpoaOcU8GDEGuDzXgxkCpyeqxRR6gLs/8JgHw"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOSQnDNrNP69tIK7U2D7qaMjycfIjpgx0at4U2D5Ufib"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK5V/hdkTTQSkDLXaEwY8xb/T8+sWtw5c6UjYOPaTrO8"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKFyKi0HYfkgvEDvjzmDRGwAq2z2KOkfv7scTVSnonBh"
  ];
}
