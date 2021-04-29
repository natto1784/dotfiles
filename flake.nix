{
  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-20.09";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = inputs@{self, nixpkgs, stable,... }:
  let
    system = "x86_64-linux";
  in
  {
     overlays = {
        overridesandshit = import ./overlays/overridesandshit.nix;
        packages = import ./overlays/packages.nix;
      };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = builtins.attrValues self.overlays;
      };
    nixosConfigurations.Satori = nixpkgs.lib.nixosSystem {
      system = "${system}";
      modules = [ 
        ./Satori/configuration.nix 
        { nixpkgs.pkgs = self.pkgs; }
      ];
    };
  };
}
