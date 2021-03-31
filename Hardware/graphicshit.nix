{lib, config, pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
  {
    environment.systemPackages = with pkgs; [
      nvidia-offload
    ];
    hardware = {
      opengl = {
        driSupport32Bit = true;
        #package = pkgs.mesa_drivers;
        enable = true;
      };
      nvidia = {
        prime = {
          offload = { enable = true; };
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
        modesetting = { enable = true; };
      };
    };
  }
