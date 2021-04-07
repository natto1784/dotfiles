{lib, config, pkgs, ... }:

{
  services.pipewire = {
    enable = true;
#    alsa = {
#      enable = true;
#      support32Bit = true;
#    };
    pulse = {
      enable = true;
    };
    config.pipewire = {
      context.properties = {
        default.clock.min-quantum = 8;
      };
    }; 
    config.pipewire-pulse = {
      context.modules = {
        pulse.min.req = "4/24000";           
        pulse.min.quantum = "4/24000";
      };
      stream.properties = {
        node.latency = "4/24000";
      };
    };
  };
  sound.enable = true;
#  hardware = {
#    pulseaudio.enable = true;
#    pulseaudio.support32Bit = true;
#  };
}
