{ pkgs, lib, config, inputs, ... }:
let
  cfg = config.programs.ags;

  deps = with pkgs; [
    sass
    gawk
    bash
    procps
    coreutils
    imagemagick
    config.wayland.windowManager.hyprland.package
  ] ++ lib.optional config.isLaptop brightnessctl;


  configDir = lib.cleanSourceWith {
    src = ./.;
    filter = name: _:
      let
        baseName = baseNameOf (toString name);
      in
        !(lib.hasSuffix ".nix" baseName);
  };
in
{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  programs.ags.enable = true;

  xdg.configFile."ags" = {
    source = configDir;
    recursive = true;
  };

  systemd.user.services.ags = {
    Unit = {
      Description = "Aylur's Gtk Shell";
      PartOf = [
        "tray.target"
        "graphical-session.target"
      ];
    };
    Service = {
      Environment = "PATH=${lib.makeBinPath deps}";
      ExecStart = "${cfg.package}/bin/ags";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
