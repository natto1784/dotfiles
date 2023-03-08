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
      package = pkgs.consul;
      extraConfigFiles = lib.singleton "/run/consul/consul.json";
    };
  };

  security.pki.certificateFiles = [ ../../cert.pem ../../consul-agent-ca.pem ];
}

