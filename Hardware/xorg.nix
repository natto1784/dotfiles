
{ config, lib, pkgs, modulesPath, ... }:

{
  services = {
    xserver = {
      enable = true;
      libinput= {
        enable = true;
        mouse = {
          accelSpeed = "0";
        };
        touchpad = {
          middleEmulation = false;
          clickMethod = "buttonareas";
          tapping = true;
          naturalScrolling =true;
        };
      };
      displayManager = {startx = {enable = true; }; };
      videoDrivers = [ "nvidia" ];
      layout = "us";
      xkbVariant = "colemak";
    };
  };
}
