{
  pkgs,
  config,
  ...
}:
let
  lock = "${pkgs.systemd}/bin/loginctl lock-session";
  timeout = 300;
in
{
  # screen idle
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        before_sleep_cmd = lock;
        lock_cmd = "pgrep hyprlock || ${config.programs.hyprlock.package}/bin/hyprlock";
      };

      listener = [
        {
          timeout = timeout;
          on-timeout = lock;
        }
      ];
    };
  };
}
