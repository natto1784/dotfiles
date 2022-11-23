{ config, pkgs, lib, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvi" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  environment.systemPackages = with pkgs; [
    nvidia-offload
  ];
  hardware = {
    opengl = {
      driSupport32Bit = true;
      enable = true;
      package = pkgs.master.mesa.drivers;
      package32 = pkgs.master.pkgsi686Linux.mesa.drivers;
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidia_x11;
      prime = {
        #      sync.enable = true;
        offload = { enable = true; };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      modesetting = { enable = true; };
      powerManagement = {
        enable = true;
        finegrained = true;
      };
    };
  };
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    dpi = 96;
  };
}
