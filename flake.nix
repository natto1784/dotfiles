{
  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-20.09";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = inputs@{self, nixpkgs, stable, flake-utils,... }:
  let
    system = "x86_64-linux";
  in
  {
     overlays = {
        overridesandshit = import ./overlays/overridesandshit.nix;
      };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = builtins.attrValues self.overlays;
      };
    nixosConfigurations.nixchod = nixpkgs.lib.nixosSystem {
      system = "${system}";
      modules = [ 
        ./configuration.nix 
        { nixpkgs.pkgs = self.pkgs; }
      ];
    };
  };
}
