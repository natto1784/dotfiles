{config, ...}:
{
  nix.buildMachines = [ {
	 hostName = "Satori";
	 system = "aarch64-linux";
	 maxJobs = 4;
	 speedFactor = 2;
	 supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
	}] ;
	nix.distributedBuilds = true;
	nix.extraOptions = ''
		builders-use-substitutes = true
	'';
}
