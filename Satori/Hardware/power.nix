{ config, lib, ... }:

{
  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "powersave";
  };
}
