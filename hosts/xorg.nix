{ config, lib, ... }:

#let
#  compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
#    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${./colemak-dh.xkb} $out
#  '';
#in
{
  services = {
    xserver = {
      enable = true;
      libinput = {
        enable = true;
        mouse = {
          accelSpeed = "0";
          #         accelProfile = "flat";
        };
        touchpad = {
          middleEmulation = false;
          clickMethod = "buttonareas";
          tapping = true;
          naturalScrolling = true;
        };
      };
      displayManager = {
        startx = {
          enable = true;
        };
      };
      xkb.layout = "us";
      xkb.variant = "colemak_dh"; # trying to ditch DHz now
      autoRepeatDelay = 320;
      autoRepeatInterval = 30;
    };
  };
}
