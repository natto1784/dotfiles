{ ... }:
{
  imports = [
    ./nginx.nix
    ./pufferpanel.nix
    ./filehost.nix
    ./gitea.nix
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
        local gitea all ident map=gitea-map
      '';
      identMap = ''
        gitea-map gitea gitea
      '';
    };
  };
}
