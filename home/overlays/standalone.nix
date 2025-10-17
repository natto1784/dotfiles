final: prev:
let
  pam = prev.pam.overrideAttrs (oa: {
    postPatch = ''
      substituteInPlace modules/module-meson.build \
        --replace "sbindir / 'unix_chkpwd'" "'/usr/bin/unix_chkpwd'"
    '';
  });
in
{
  hyprlock = prev.hyprlock.override { inherit pam; };
  swaylock = prev.swaylock.override { inherit pam; };
}
