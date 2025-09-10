{
  lib,
  pkgs,
  ...
}:
let

  standalonePam = pkgs.linux-pam.overrideAttrs (oa: {
    postPatch = ''
      substituteInPlace modules/module-meson.build \
        --replace "sbindir / 'unix_chkpwd'" "'/usr/bin/unix_chkpwd'"
    '';
  });
in
{
  programs.hyprlock.package = lib.mkForce (pkgs.hyprlock.override { pam = standalonePam; });
}
