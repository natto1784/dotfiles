{
  inputs = {
    stable.url = github:nixos/nixpkgs/nixos-20.09;
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = github:nix-community/NUR;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = github:ryantm/agenix;
  };

  outputs = inputs@{self, nixpkgs, ... }:

  let
    system = "x86_64-linux";
    ov = (builtins.attrValues self.overlays) ++ [ inputs.nur.overlay ];
  in
  {
    overlays = {
      overridesandshit = import ./overlays/overridesandshit.nix;
      packages = import ./overlays/packages.nix;
    };

    hm-configs = {
      natto = inputs.home-manager.lib.homeManagerConfiguration {
        configuration = { pkgs, lib, ... }: {
          imports = [ 
            ./home/natto.nix 
          ];
          nixpkgs.overlays = ov;
        };
        system = "${system}";
        homeDirectory = "/home/natto";
        username = "natto";
      };
    };

    nixosConfigurations.Satori = nixpkgs.lib.nixosSystem {
      system = "${system}";
      modules = [ 
        ./satori.nix 
        inputs.agenix.nixosModules.age
        inputs.home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = ov;
          #environment.systemPackages = with inputs; [ claudius ];
        }
      ];
    };
  };
}
