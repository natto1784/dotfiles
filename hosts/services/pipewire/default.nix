{ lib, config, pkgs, ... }: {
  # sound stuff
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    socketActivation = true;
    wireplumber.enable = true;
  };
}
