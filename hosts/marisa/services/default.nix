{ config, ... }:
{

  imports = [
    # ./hashicorp.nix
  ];

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
    };
  };
  services = {
    openssh = {
      enable = true;
      ports = [
        22
        22001
      ];
    };
  };
}
