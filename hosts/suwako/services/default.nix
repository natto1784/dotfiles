{ ... }:
{
  imports = [
    ./nginx.nix
    ./pufferpanel.nix
    ./filehost.nix
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
  };
}
