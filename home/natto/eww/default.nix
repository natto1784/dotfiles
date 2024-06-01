{ config, pkgs, lib, ... }:
{
  programs.eww = {
    enable = true;
    package = pkgs.eww;
    configDir = lib.cleanSourceWith {
      src = ./.;
      filter = name: _:
        let
          baseName = baseNameOf (toString name);
        in
          !(lib.hasSuffix ".nix" baseName);
    };
  };

  systemd.user.services.eww = {
    Unit = {
      Description = "EWW Daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service =
      let
        deps = [
          config.programs.eww.package
        ] ++ lib.optional
          config.wayland.windowManager.hyprland.enable
          config.wayland.windowManager.hyprland.package
        ++ (with pkgs; [
          coreutils
          bash
          jq
          less
          gawk
          socat
          playerctl
          networkmanager
          iwgtk
          wireplumber
        ])
        ++ lib.optional config.laptop pkgs.light;
      in
      {
        Type = "simple";
        Environment = "PATH=${lib.makeBinPath deps}";
        Restart = "on-failure";
        ExecStart = "${config.programs.eww.package}/bin/eww daemon --no-daemonize";
      };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}

