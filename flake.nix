{ 
  inputs = {
    stable.url = github:nixos/nixpkgs/nixos-21.11;
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    master.url = github:nixos/nixpkgs/master;
    home-manager.url = github:nix-community/home-manager;
    home-manager-stable.url = github:nix-community/home-manager/release-21.11;
    nur.url = github:nix-community/NUR;
    agenix.url = github:ryantm/agenix;
    utils.url = github:numtide/flake-utils;
    nvim.url = github:nix-community/neovim-nightly-overlay;
    mailserver.url = gitlab:simple-nixos-mailserver/nixos-mailserver;
    nbfc.url = github:natto1784/nbfc-linux/yawr;
    emacs.url = github:nix-community/emacs-overlay;
    nix-gaming.url = github:fufexan/nix-gaming;
    rust.url = github:oxalica/rust-overlay;
  };

  outputs = inputs@{self, nixpkgs, stable, master,  ... }:
  inputs.utils.lib.eachDefaultSystem (system: 
  let
    mkPkgs = channel: system: import channel {
      inherit system;
      config.allowUnfree = true;
    };
    channels = final: prev: {
      stable   = mkPkgs stable  prev.system;
      unstable = mkPkgs nixpkgs prev.system;
      master   = mkPkgs master  prev.system;
    };
    overlays = [
      (import ./overlays/overridesandshit.nix)
      (import ./overlays/packages.nix)
    ];
  in
  {
    legacyPackages = import nixpkgs {
      inherit system;
      overlays = overlays ++ [ 
        inputs.nur.overlay 
        inputs.nvim.overlay
        inputs.rust.overlay
        inputs.emacs.overlay
        channels
        ( _: _: {
          nbfc-linux=inputs.nbfc.defaultPackage.${system};
          games = inputs.nix-gaming.packages.${system};
        })
      ];
      config.allowUnfree = true;
      config.allowBroken = true;
    };
  }) //
  ( 
  let 
    personalModules = [
      ./modules/nvidia-offload.nix
      ./modules/sound.nix
      ./modules/xorg.nix
      ./modules/emacs
    ];
    commonModules = [
      ./modules/nvim
      ./modules/vault-agent.nix
    ];
    serverModules = [
      ./modules/builder.nix
      ./modules/min-pkgs.nix
      ./modules/min-stuff.nix
    ];
  in
  {
    hm-configs = {
      natto = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        configuration = { lib, ... }: {
          imports = [ 
            ./home/natto.nix 
          ];
          nixpkgs = {
            overlays = self.legacyPackages.x86_64-linux.overlays;
            config.allowUnfree = true;
            config.allowBroken = true;
            config.permittedInsecurePackages = [
              "electron-9.4.4"
            ];
          };
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
          ./hosts/satori
          inputs.agenix.nixosModules.age
          {
            nixpkgs.pkgs = self.legacyPackages.x86_64-linux; 
          }
        ]
        ++ personalModules
        ++ commonModules;
      };

      #Home server (RPi4)
      Marisa = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/marisa
          #inputs.mailserver.nixosModules.mailserver
          {
            nixpkgs.pkgs = self.legacyPackages.aarch64-linux; 
          }
        ]
        ++ commonModules
        ++ serverModules;
      };

      #Oracle Cloud VM
      Remilia = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/remilia
          inputs.mailserver.nixosModules.mailserver
          {
            nixpkgs.pkgs = self.legacyPackages.x86_64-linux; 
          }
        ]
        ++ commonModules
        ++ serverModules;
      };
    };
  });
}
