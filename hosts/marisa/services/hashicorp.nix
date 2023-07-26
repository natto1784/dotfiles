{ config, pkgs, ... }:
{

  services = {
    nomad = {
      enable = true;
      enableDocker = true;
      dropPrivileges = false;
      extraPackages = with pkgs; [ consul cni-plugins ];
      extraSettingsPaths = [ "/run/nomad/nomad.json" ];
    };
    vault = {
      package = pkgs.vault-bin;
      enable = true;
      tlsCertFile = "/var/rootcert/cert.pem";
      tlsKeyFile = "/var/rootcert/key.pem";
      address = "0.0.0.0:8800";
      # storageBackend = "file";
      # storagePath = "/var/lib/vault";
      extraSettingsPaths = [ "/run/vault/vault.json" ];
    };

    consul = {
      enable = true;
      package = pkgs.consul;
      extraConfigFiles = [ "/run/consul/consul.json" ];
    };
  };
}

