{ config, lib, ... }:

{
  services = {
    libinput = {
      enable = true;
      mouse = {
        accelSpeed = "0";
      };
      touchpad = {
        middleEmulation = false;
        clickMethod = "buttonareas";
        tapping = true;
        naturalScrolling = true;
      };
    };
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      xkb.layout = "us";
      xkb.variant = "colemak_dh";
      autoRepeatDelay = 320;
      autoRepeatInterval = 30;
    };
  };
}
