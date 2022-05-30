{ config, pkgs, lib, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvi" ''
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
    /*   opengl =
      let
      fn = oa: with lib; {
      nativeBuildInputs = oa.nativeBuildInputs ++ singleton pkgs.glslang;
      mesonFlags = oa.mesonFlags ++ singleton "-Dvulkan-layers=device-select,overlay";
      patches = oa.patches ++ singleton ./mesa-vulkan-layer-nvidia.patch;
      postInstall = oa.postInstall + ''
      mv $out/lib/libVkLayer* $drivers/lib
      layer=VkLayer_MESA_device_select
      substituteInPlace $drivers/share/vulkan/implicit_layer.d/''${layer}.json \
      --replace "lib''${layer}" "$drivers/lib/lib''${layer}"
      layer=VkLayer_MESA_overlay
      substituteInPlace $drivers/share/vulkan/explicit_layer.d/''${layer}.json \
      --replace "lib''${layer}" "$drivers/lib/lib''${layer}"
      '';
      };
      in
      with pkgs; {
      driSupport32Bit = true;
      enable = true;
      package = (mesa.overrideAttrs fn).drivers;
      package32 = (pkgsi686Linux.mesa.overrideAttrs fn).drivers;
      };*/
    opengl = {
      driSupport32Bit = true;
      enable = true;
    };
    nvidia = {
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
