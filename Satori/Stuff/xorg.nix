
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
      libinput= {
        enable = true;
 #       mouse = {
 #         accelSpeed = "0";
 #       };
        touchpad = {
          middleEmulation = false;
          clickMethod = "buttonareas";
          tapping = true;
          naturalScrolling =true;
        };
      };
      displayManager = {
        startx = {
          enable = true; 
        }; 
#       sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY";
      };
#      extraLayouts = {
#        colemak-dh = {
#          description = "Colemak with MOD-dh";
#          languages = [ "eng" ];
#          symbolsFile = ./colemak-dh;
#        };
#      };
      videoDrivers = [ "nvidia" ];
      layout = "us";
      xkbVariant = "colemak";
    };
  };
}
