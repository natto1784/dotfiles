{ config, ... }:

{
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };
}
