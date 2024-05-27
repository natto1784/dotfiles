#Taken from https://github.com/MagicRB/dotfiles/blob/master/nix/nixos-modules/vault-agent.nix
{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.vault-agent;
  json = pkgs.formats.json { };
in
{
  options = {
    services.vault-agent = {
      enable = mkEnableOption "Vault Agent";

      package = mkOption {
        type = types.package;
        default = pkgs.vault;
        description = ''
          The package used for the vault agent
        '';
      };

      settings = mkOption {
        type = json.type;
        default = { };
        description = ''
          Settings for the agent
        '';
      };

      secretsDir = mkOption {
        type = types.nullOr types.path;
        default = "/var/secrets";
        description = ''
          Vault secrets directory;
        '';
      };

      userName = mkOption {
        type = types.str;
        default = "vault-agent";
        description = "Username for the service";
      };

      groupName = mkOption {
        type = types.str;
        default = "vault-agent";
        description = "Vault-Agent Group Name";
      };

      uid = mkOption {
        type = types.int;
        default = 1985;
      };

      gid = mkOption {
        type = types.int;
        default = 1985;
      };

    };
  };

  config = mkIf cfg.enable
    ({
      users = {
        users = {
          "${cfg.userName}" = {
            group = cfg.groupName;
            uid = cfg.uid;
            isSystemUser = true;
            description = "Vault-Agent User";
          };
        };
        groups = {
          "${cfg.groupName}" = {
            gid = cfg.gid;
          };
        };
      };
      systemd.tmpfiles.rules = mkIf (cfg.secretsDir != null) [
        "d ${cfg.secretsDir} 6755 vault-agent ${cfg.groupName} 0"
      ];
      systemd.services.vault-agent = {
        description = "Vault Agent";
        wantedBy = [ "multi-user.target" ];
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
        path = (with pkgs; [
          glibc
        ]);
        serviceConfig = {
          User = cfg.userName;
          Group = cfg.groupName;
          ExecReload = "${pkgs.busybox}/bin/kill -HUP $MAINPID";
          ExecStart = "${cfg.package}/bin/vault agent -config=${json.generate "vault.json" cfg.settings}";
          KillMode = "process";
          KillSignal = "SIGINT";
          Restart = "on-failure";
          TimeoutStopSec = "30s";
          RestartSec = 2;
          ConfigurationDirectory = "vault-agent";
          ConfigurationDirectoryMode = "0600";
        };
      };
    });
}

