{ 
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    stable.url = github:nixos/nixpkgs/nixos-21.05;
    master.url = github:nixos/nixpkgs/master;
    home-manager.url = github:nix-community/home-manager;
    nur.url = github:nix-community/NUR;
    agenix.url = github:ryantm/agenix;
    utils.url = github:numtide/flake-utils;
    nvim.url = github:nix-community/neovim-nightly-overlay;
    mailserver.url = gitlab:simple-nixos-mailserver/nixos-mailserver;
  };

  outputs = inputs@{self, nixpkgs, stable, master,  ... }:
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
      overlays = overlays ++ [ 
        inputs.nur.overlay 
        inputs.nvim.overlay 
        (_:_: {unstable = nixpkgs.legacyPackages.${system};})
        (_:_: {stable = stable.legacyPackages.${system};})
        (_:_: {master = master.legacyPackages.${system};})
      ];
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
    };

    nixosConfigurations = {
      #Home laptop
      Satori = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./hosts/personal/satori.nix
          inputs.agenix.nixosModules.age
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.pkgs = self.packages.x86_64-linux; 
          }
        ];
      };
      #Home server (RPi4)
      Marisa = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ 
          ./modules/vault-agent.nix
          ./hosts/servers/marisa.nix
          #inputs.mailserver.nixosModules.mailserver
          {
            nixpkgs.pkgs = self.packages.aarch64-linux; 
          }
        ];
      };
      #idk, maybe to try cross compiling Marisa on home laptop later?
      Marisus = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ 
          ./hosts/servers/marisa.nix
          {
            nixpkgs.pkgs = (self.packages.x86_64-linux) // {crossSystem.config = "aarch64-unknown-linux-gnu";};
          }
        ];
      };
      #Oracle Cloud VM
      Remilia = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./modules/vault-agent.nix
          ./hosts/servers/remilia.nix
          inputs.mailserver.nixosModules.mailserver
          {
            nixpkgs.pkgs = self.packages.x86_64-linux; 
          }
        ];
      };
    };
  });
}
