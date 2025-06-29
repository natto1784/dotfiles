{
  config,
  pkgs,
  lib,
  conf,
  ...
}:
let
  domain = conf.network.addresses.domain.natto;
in
{
  services = {
    cron.enable = true;

    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
      ports = [ 22 ];
    };
  };
}
