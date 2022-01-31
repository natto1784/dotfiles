/* Module by @ryantm in github:ryantm/agenix */

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.age;
  ageBin = "${pkgs.rage}/bin/rage";
  users = config.users.users;
  home_ = config.home.homeDirectory;
  username_ = config.home.username;
  identities = builtins.concatStringsSep " " (map (path: "-i ${path}") cfg.sshKeyPaths);
  installSecret = secretType: ''
    echo "decrypting ${secretType.file} to ${secretType.path}..." 
    TMP_FILE="${secretType.path}.tmp"
    mkdir -p $(dirname ${secretType.path})
    (umask 0400; ${ageBin} --decrypt ${identities} -o "$TMP_FILE" "${secretType.file}")
    chmod ${secretType.mode} "$TMP_FILE"
    chown ${secretType.owner} "$TMP_FILE"
    mv -f "$TMP_FILE" '${secretType.path}'
  '';

  secretType = types.submodule ({ config, ... }: {
    options = {
      name = mkOption {
        type = types.str;
        default = config._module.args.name;
        description = ''
          Name of the file used in /run/secrets
        '';
      };
      file = mkOption {
        type = types.path;
        description = ''
          Age file the secret is loaded from.
        '';
      };
      path = mkOption {
          type = types.str;
          default = "${home_}/.secrets/${config.name}";
          description = ''
            Path where the decrypted secret is installed.
          '';
        };
      mode = mkOption {
        type = types.str;
        default = "0400";
        description = ''
          Permissions mode of the in octal.
        '';
      };
      owner = mkOption {
        type = types.str;
        default = "${username_}";
        description = ''
          User of the file.
        '';
      };
    };
  });
in {
  
  options.age = {
    secrets = mkOption {
      type = types.attrsOf secretType;
      default = {};
      description = ''
        Attrset of secrets.
      '';
    };

    sshKeyPaths = mkOption {
      type = types.listOf types.path;
      default = [  ];
      description = ''
        Path to SSH keys to be used as identities in age decryption.
      '';
    };
  };
  config = mkIf (cfg.secrets != {}) {
    assertions = [{
      assertion = cfg.sshKeyPaths != [];
      message = "age.sshKeyPaths must be set.";
    }];
    home.activation = {
      decryptSecrets = lib.hm.dag.entryBefore [ "writeBoundary" ] (concatStrings (map installSecret (builtins.attrValues cfg.secrets)));
    };
  };
}


