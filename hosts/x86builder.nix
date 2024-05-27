{ config, ... }:
{
  nix = {
    extraOptions = ''
      builders-use-substitutes = true
    '';
    buildMachines = [{
      hostName = "satori";
      systems = [ "x86_64-linux" "aarch64-linux" ];
      maxJobs = 4;
      speedFactor = 2;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    }];
    distributedBuilds = true;
  };
}
