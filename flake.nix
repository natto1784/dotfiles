{
  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-20.09";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{self, nixpkgs, stable, home-manager,... }:
  let
    system = "x86_64-linux";
  in
  {
    overlays = {
      overridesandshit = import ./overlays/overridesandshit.nix;
      packages = import ./overlays/packages.nix;
    };

    hm-configs = {
      natto = home-manager.lib.homeManagerConfiguration {
        configuration = { pkgs, lib, ... }: {
          imports = [ ./home/natto.nix ];
          nixpkgs = {
            overlays = builtins.attrValues self.overlays;
          };
        };
        system = "${system}";
        homeDirectory = "/home/natto";
        username = "natto";
      };
    };

    nixosConfigurations.Satori = nixpkgs.lib.nixosSystem {
      system = "${system}";
      modules = [ 
        ./Satori/configuration.nix 
        { nixpkgs.overlays = builtins.attrValues self.overlays; }
      ];
    };
  };
}
