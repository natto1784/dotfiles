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
    emacs = {
      url = github:nix-community/emacs-overlay;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils.url = github:numtide/flake-utils;
  };

  outputs = inputs@{self, nixpkgs, ... }:
  inputs.utils.lib.eachDefaultSystem (system: {
    pkgs = import nixpkgs {
      inherit system;
      overlays = self.overlays ++ [ inputs.nur.overlay inputs.emacs.overlay ];
      config.allowUnfree = true;
    };
  }) //
  (  
  let
  in
  {
    overlays = [
      (import ./overlays/overridesandshit.nix)
      (import ./overlays/packages.nix)
    ];
    hm-configs = {
      natto = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        configuration = { lib, ... }: {
          imports = [ 
            ./home/natto.nix 
          ];
          nixpkgs.overlays = self.pkgs.x86_64-linux.overlays;
          nixpkgs.config.allowUnfree = true;
        };
        homeDirectory = "/home/natto";
        username = "natto";
      };
    };

    nixosConfigurations.Satori = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./satori.nix 
        inputs.agenix.nixosModules.age
        inputs.home-manager.nixosModules.home-manager
        { nixpkgs.pkgs = self.pkgs.x86_64-linux; }
      ];
    };
  });
}
