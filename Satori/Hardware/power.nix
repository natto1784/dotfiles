{ config, lib, pkgs, modulesPath, ... }:

{
  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "powersave";
  };
}
