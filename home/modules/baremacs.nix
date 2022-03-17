#modified version of home-manager emacs service module for personal use

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.baremacs;
  emacsCfg = config.programs.emacs;
  emacsBinPath = "${cfg.package}/bin";

  # Match the default socket path for the Emacs version so emacsclient continues
  # to work without wrapping it.
  socketDir = "%t/emacs";
  socketPath = "${socketDir}/server";

in
{
  options.services.baremacs = {
    enable = mkEnableOption "the Emacs daemon";

    package = mkOption {
      type = types.package;
      default = pkgs.emacs;
      defaultText = literalExpression ''
        pkgs.emacs
      '';
      description = "The Emacs package to use.";
    };

    socketActivation = {
      enable = mkEnableOption "systemd socket activation for the Emacs service";
    };

    defaultEditor = {
      enable = mkOption rec {
        type = types.bool;
        default = false;
        example = !default;
        description = "Whether to change the EDITOR environment variable or not";
      };
      editor = mkOption rec {
        type = types.enum [ "emacs" "emacsclient" ];
        default = null;
        example = "emacsclient";
        description = "Whether to change the EDITOR environment variable or not";
      };
    };

    copyConfigFiles = {
      enable = mkOption rec {
        type = types.bool;
        default = false;
        example = !default;
        description = "Whether to copy the config files to ~/.emacs.d or not";
      };
      files = mkOption rec {
        type = types.attrsOf types.path;
        default = { };
        example = { "init.el" = ./init.el; };
        description = "What files to copy under what name";
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        (lib.hm.assertions.assertPlatform "services.emacs" pkgs
          lib.platforms.linux)
        {
          assertion = cfg.defaultEditor.enable -> cfg.defaultEditor.editor != null;
          message = ''
            services.baremacs.defaultEditor.enable requires services.baremacs.defaultEditor.editor to be set
          '';
        }
      ];

      systemd.user.services.emacs = {
        Unit = {
          Description = "Emacs text editor";
          Documentation =
            "info:emacs man:emacs(1) https://gnu.org/software/emacs/";

          # Avoid killing the Emacs session, which may be full of
          # unsaved buffers.
          X-RestartIfChanged = false;
        } // optionalAttrs (cfg.socketActivation.enable) {
          # Emacs deletes its socket when shutting down, which systemd doesn't
          # handle, resulting in a server without a socket.
          # See https://github.com/nix-community/home-manager/issues/2018
          RefuseManualStart = true;
        };

        Service = {
          Type = "notify";

          # We wrap ExecStart in a login shell so Emacs starts with the user's
          # environment, most importantly $PATH and $NIX_PROFILES. It may be
          # worth investigating a more targeted approach for user services to
          # iport the user environment.
          ExecStart = ''
            ${pkgs.runtimeShell} -l -c "${emacsBinPath}/emacs --fg-daemon${
            # In case the user sets 'server-directory' or 'server-name' in
            # their Emacs config, we want to specify the socket path explicitly
            # so launching 'emacs.service' manually doesn't break emacsclient
            # when using socket activation.
              optionalString cfg.socketActivation.enable
              "=${escapeShellArg socketPath}"
            }"'';

          # Emacs will exit with status 15 after having received SIGTERM, which
          # is the default "KillSignal" value systemd uses to stop services.
          SuccessExitStatus = 15;

          Restart = "on-failure";
        } // optionalAttrs (cfg.socketActivation.enable) {
          # Use read-only directory permissions to prevent emacs from
          # deleting systemd's socket file before exiting.
          ExecStartPost =
            "${pkgs.coreutils}/bin/chmod --changes -w ${socketDir}";
          ExecStopPost =
            "${pkgs.coreutils}/bin/chmod --changes +w ${socketDir}";
        };
      } // optionalAttrs (!cfg.socketActivation.enable) {
        Install = { WantedBy = [ "default.target" ]; };
      };

      home = {
        sessionVariables = mkIf cfg.defaultEditor.enable {
          EDITOR = let editor = cfg.defaultEditor.editor; in
            getBin (pkgs.writeShellScript "editor" ''
              exec ${
                getBin cfg.package
              }/bin/'' + editor + head (optional (editor == "emacsclient") '' "''${@:---create-frame}"''));
        };

        file = mkIf cfg.copyConfigFiles.enable
          (mapAttrs'
            (n: v:
              attrsets.nameValuePair (".emacs.d/" + n) { source = v; })
            cfg.copyConfigFiles.files);
      };
    }

    (mkIf cfg.socketActivation.enable {
      systemd.user.sockets.emacs = {
        Unit = {
          Description = "Emacs text editor";
          Documentation =
            "info:emacs man:emacs(1) https://gnu.org/software/emacs/";
        };

        Socket = {
          ListenStream = socketPath;
          FileDescriptorName = "server";
          SocketMode = "0600";
          DirectoryMode = "0700";
        };
        Install = { WantedBy = [ "sockets.target" ]; };
      };
    })
  ]);
}
