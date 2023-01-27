{ config, pkgs, lib, ... }:
{
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
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
    };
    Service =
      let
        deps = [
          config.programs.eww.package
          config.wayland.windowManager.hyprland.package
        ] ++ (import ./bar pkgs);
      in
      {
        Environment = "PATH=${lib.makeBinPath deps}";
        Type = "simple";
        Restart = "on-failure";
        ExecStart = "${config.programs.eww.package}/bin/eww daemon --no-daemonize";
      };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}

