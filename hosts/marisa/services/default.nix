{ config, ... }:
{

  imports = [
   # ./hashicorp.nix
  ];

  # Add secrets to nomad, consul and vault
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      #     default-cgroupns-mode = "host";
    };
  };
  systemd.tmpfiles.rules = [ "d /run/vault - vault vault 1h" ];
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
  };
}

