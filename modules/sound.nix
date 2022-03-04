{ lib, config, pkgs, ... }:

{
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      socketActivation = true;

      #  https://nixos.wiki/wiki/PipeWire#Low-latency_setup
      config.pipewire = {
        context.objects = [
          {
            factory = "spa-node-factory";
            args = {
              factory.name = "support.node.driver";
              node.name = "Dummy-Driver";
              priority.driver = 8000;
            };
          }
        ];
        context.modules = [
          {
            name = "libpipewire-module-rtkit";
            args = {
              nice.level = -15;
              rt.prio = 88;
              rt.time.soft = 200000;
              rt.time.hard = 200000;
            };
            flags = [ "ifexists" "nofail" ];
          }
          { name = "libpipewire-module-protocol-native"; }
          { name = "libpipewire-module-profiler"; }
          { name = "libpipewire-module-metadata"; }
          { name = "libpipewire-module-spa-device-factory"; }
          { name = "libpipewire-module-spa-node-factory"; }
          { name = "libpipewire-module-client-node"; }
          { name = "libpipewire-module-client-device"; }
          {
            name = "libpipewire-module-portal";
            flags = [ "ifexists" "nofail" ];
          }
          {
            name = "libpipewire-module-access";
            args = { };
          }
          { name = "libpipewire-module-adapter"; }
          { name = "libpipewire-module-link-factory"; }
          { name = "libpipewire-module-session-manager"; }
        ];
      };

      config.pipewire-pulse = {
        context.modules = [
          { name = "libpipewire-module-protocol-native"; }
          { name = "libpipewire-module-client-node"; }
          { name = "libpipewire-module-adapter"; }
          { name = "libpipewire-module-metadata"; }
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "32/48000";
              pulse.min.quantum = "32/48000";
              pulse.min.frag = "32/48000";
            };
          }
        ];
        stream.properties = {
          node.latency = "32/48000";
          resample.quality = 1;
        };
      };
    };
  };
  sound.enable = true;
  /*  hardware = {
    pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudio.override { jackaudioSupport = true; };
    };
    };*/
}
