{ 
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-21.05;
    unstable.url = github:nixos/nixpkgs/nixpkgs-unstable;
    master.url = github:nixos/nixpkgs/master;
    home-manager-unstable.url = github:nix-community/home-manager;
    home-manager.url = github:nix-community/home-manager/release-21.05;
    nur.url = github:nix-community/NUR;
    agenix.url = github:ryantm/agenix;
    utils.url = github:numtide/flake-utils;
    nvim.url = github:nix-community/neovim-nightly-overlay;
    mailserver.url = gitlab:simple-nixos-mailserver/nixos-mailserver;
    osu-nix.url = github:fufexan/osu.nix;
  };

  outputs = inputs@{self, nixpkgs, unstable, master,  ... }:
  inputs.utils.lib.eachDefaultSystem (system: 
  let
    channels = final: prev: {
      unstable = unstable.legacyPackages.${prev.system};
      master = master.legacyPackages.${prev.system};
      stable = nixpkgs.legacyPackages.${prev.system};
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
        channels
        (_:_: {osu-nix = inputs.osu-nix.defaultPackage.${system};})
      ];
      config.allowUnfree = true;
      config.allowBroken = true;
    };
  }) //
  ( 
  let 
    personalModules = [
      ./modules/nvidia-offload.nix
      ./modules/pipewire.nix
      ./modules/xorg.nix
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
          nixpkgs.overlays = self.legacyPackages.x86_64-linux.overlays;
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
          ./hosts/satori
          inputs.agenix.nixosModules.age
          inputs.home-manager.nixosModules.home-manager
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
