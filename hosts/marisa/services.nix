{ lib, config, pkgs, ... }:
{

  # Add secrets to nomad, consul and vault
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      #     default-cgroupns-mode = "host";
    };
  };
  systemd.tmpfiles.rules = lib.singleton "d /run/vault - vault vault 1h";
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
    nomad = {
      enable = true;
      enableDocker = true;
      dropPrivileges = false;
      extraPackages = with pkgs; [ consul ];
      extraSettingsPaths = lib.singleton "/run/nomad/nomad.json";
    };
    vault = {
      package = pkgs.vault-bin;
      enable = true;
      tlsCertFile = "/var/rootcert/cert.pem";
      tlsKeyFile = "/var/rootcert/key.pem";
      address = "0.0.0.0:8800";
      # storageBackend = "file";
      # storagePath = "/var/lib/vault";
      extraSettingsPaths = lib.singleton "/run/vault/vault.json";
    };

    consul = {
      enable = true;
      package = pkgs.master.consul;
      extraConfigFiles = lib.singleton "/run/consul/consul.json";
    };
  };
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJHingN2Aho+KGgEvBMjtoez+W1svl9uVoa4vG0d646j"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPX1HDzWpoaOcU8GDEGuDzXgxkCpyeqxRR6gLs/8JgHw"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOSQnDNrNP69tIK7U2D7qaMjycfIjpgx0at4U2D5Ufib"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK5V/hdkTTQSkDLXaEwY8xb/T8+sWtw5c6UjYOPaTrO8"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKFyKi0HYfkgvEDvjzmDRGwAq2z2KOkfv7scTVSnonBh"
  ];
  security.pki.certificateFiles = [ ../../cert.pem ../../consul-agent-ca.pem ];

}

