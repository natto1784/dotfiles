{ ... }:
{
  imports = [
    ./nginx.nix
    ./pufferpanel.nix
    ./filehost.nix
    ./forgejo.nix
  ];

  virtualisation.docker = {
    enable = true;
  };

  services = {
    cron.enable = true;

    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
      ports = [ 22 ];
    };

    postgresql = {
      enable = true;

      authentication = ''
        # forgejo
        local forgejo all ident map=forgejo-map
      '';

      identMap = ''
        forgejo-map forgejo forgejo
      '';
    };
  };
}
