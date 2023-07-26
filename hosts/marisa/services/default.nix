{ config, ... }:
{

  imports = [
    # ./hashicorp.nix
    ./filehost.nix
    ./gitea.nix
  ];

  # Add secrets to nomad, consul and vault
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      #     default-cgroupns-mode = "host";
    };
  };
  services = {
    openssh = {
      enable = true;
      ports = [22 22001];
    };
    postgresql = {
      enable = true;
      authentication = ''
        local gitea all ident map=gitea-map
      '';
      identMap =
        ''
          gitea-map gitea gitea
        '';
    };

  };
}

