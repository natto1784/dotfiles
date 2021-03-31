{lib, config, pkgs, ... }:

{

#services.pipewire = {
# enable = true;
#  pulse.enable = true;
# config.pipewire = {
#  context.properties = {
#   default.clock.min-quantum = 8;
# };
#};
# config.pipewire-pulse = {
#  context.modules = {
#     pulse.min.req = "4/48000";           # 0.08ms
#    pulse.min.quantum = "4/48000";         # 0.08ms
#};
#stream.properties = {
#  node.latency = "4/48000";
# };
#};
#};
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
  };
}
