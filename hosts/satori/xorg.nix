{ config, lib, ... }:

#let
#  compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
#    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${./colemak-dh.xkb} $out
#  '';
#in
{
  console.useXkbConfig = true;
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
      extraLayouts = {
        us-colemak = {
          description = "Colemak with MOD-dh";
          languages = [ "eng" ];
          symbolsFile = ./colemak-dh;
        };
      };
      layout = "us-colemak";
      xkbVariant = "basic";
      autoRepeatDelay = 320;
      autoRepeatInterval = 30;
    };
  };
}
