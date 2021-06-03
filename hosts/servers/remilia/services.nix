{config, pkgs, ...}:
{
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
    nginx = {
      enable = true;
      package = pkgs.nginx;
      virtualHosts = {
        "weirdnatto.in" = {
          addSSL = true;
          enableACME = true;
          locations."/".proxyPass = "http://10.55.0.2:80";
        };
        "git.weirdnatto.in" = {
          addSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://10.55.0.2:5001";
            extraConfig = ''
              proxy_set_header Host $host;
              '';
          };
        };
        "mail.weirdnatto.in" = {
          addSSL = true;
          enableACME = true;
          locations."/" = {};
        };
      };
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJHingN2Aho+KGgEvBMjtoez+W1svl9uVoa4vG0d646j"
  ];
  security.acme = {
    acceptTerms = true;
    certs = {
      "weirdnatto.in".email = "natto+acme@weirdnatto.in";    
      "git.weirdnatto.in".email = "git+acme@weirdnatto.in";    
      "mail.weirdnatto.in".email = "mail+acme@weirdnatto.in";    
    };
  };
}
