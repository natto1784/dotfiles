{ lib, config, pkgs, ... }:
{
  time.timeZone = "Asia/Kolkata";

  environment.localBinInPath = true;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.enable = true;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "natto" ];
          keepEnv = true;
          persist = true;
          setEnv = [ "SSH_AUTH_SOCK" "PATH" "SHELL" ];
        }
      ];
    };
  };
  console.useXkbConfig = true;

  users.users.natto = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/natto";
    extraGroups = [ "wheel" "adbusers" "video" "libvirtd" "docker" "networkmanager" "dialout" ];
  };

  virtualisation = {
    waydroid.enable = true;
    podman = {
      enable = true;
    };
  };

  gtk.iconCache.enable = true;

  security.wrappers = {
    intel_gpu_top = {
      owner = "root";
      group = "root";
      capabilities = "cap_perfmon=+ep";
      source = "${pkgs.intel-gpu-tools}/bin/intel_gpu_top";
    };
  };
}
