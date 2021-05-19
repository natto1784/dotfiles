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
    utils.url = github:numtide/flake-utils;
  };

  outputs = inputs@{self, nixpkgs, ... }:
  inputs.utils.lib.eachDefaultSystem (system: 
  let
    overlays = [
      (import ./overlays/overridesandshit.nix)
      (import ./overlays/packages.nix)
    ];
  in
  {
    packages = import nixpkgs {
      inherit system;
      overlays = overlays ++ [ inputs.nur.overlay ];
      config.allowUnfree = true;
      config.allowBroken = true;
    };
  }) //
  (  
  {
    hm-configs = {
      natto = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        configuration = { lib, ... }: {
          imports = [ 
            ./home/natto.nix 
          ];
          nixpkgs.overlays = self.packages.x86_64-linux.overlays;
          nixpkgs.config.allowUnfree = true;
          nixpkgs.config.allowBroken = true;
        };
        homeDirectory = "/home/natto";
        username = "natto";
      };
      ottan = inputs.home-manager.lib.homeManagerConfiguration {
        system = "aarch64-linux";
        configuration = { lib, ... }: {
          imports = [ 
            ./home/ottan.nix 
          ];
          nixpkgs.overlays = self.packages.aarch64-linux.overlays;
        };
        homeDirectory = "/home/ottan";
        username = "ottan";
      };

    };

    nixosConfigurations = {
      Satori = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./satori.nix
          inputs.agenix.nixosModules.age
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.pkgs = self.packages.x86_64-linux; 
          }
        ];
      };
      Marisa = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ 
          ./marisa.nix
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.pkgs = self.packages.aarch64-linux; 
          }
        ];
      };
    };
  });
}
