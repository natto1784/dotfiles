{
  inputs = {
    stable.url = github:nixos/nixpkgs/nixos-22.05;
    stable-small.url = github:nixos/nixpkgs/nixos-22.05-small;
    old.url = github:nixos/nixpkgs/nixos-21.11;
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    master.url = github:nixos/nixpkgs/master;
    home-manager.url = github:nix-community/home-manager;
    home-manager-stable.url = github:nix-community/home-manager/release-21.11;
    nur.url = github:nix-community/NUR;
    utils.url = github:numtide/flake-utils;
    nvim.url = github:nix-community/neovim-nightly-overlay;
    mailserver.url = gitlab:simple-nixos-mailserver/nixos-mailserver;
    nbfc.url = github:nbfc-linux/nbfc-linux;
    emacs.url = github:nix-community/emacs-overlay;
    nix-gaming.url = github:fufexan/nix-gaming;
    rust.url = github:oxalica/rust-overlay;
  };

  outputs = inputs@{ self, utils, nixpkgs, stable, master, old, stable-small, ... }:
    with utils.lib; eachSystem
      (with system;
      [ x86_64-linux aarch64-linux ])
      (system:
        let
          mkPkgs = channel: system: import channel {
            inherit system;
            config.allowUnfree = true;
            config.allowBroken = true;
          };
          channels = final: prev: {
            stable = mkPkgs stable prev.system;
            stable-small = mkPkgs stable-small prev.system;
            unstable = mkPkgs nixpkgs prev.system;
            master = mkPkgs master prev.system;
            old = mkPkgs old prev.system;
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
              inputs.rust.overlays.default
              inputs.emacs.overlay
              channels
              (_: _: {
                nbfc-linux = inputs.nbfc.packages.${system}.nbfc-client-c;
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
          ./modules/graphics.nix
          ./modules/sound.nix
          ./modules/xorg.nix
        ];
        commonModules = [
          ./modules/nvim
          ./modules/vault-agent.nix
          ./modules/cachix.nix
        ];
        serverModules = [
          ./modules/min-pkgs.nix
          ./modules/min-stuff.nix
        ];
        homeModules = [
          ./home/modules/secret.nix
          ./home/modules/baremacs.nix
        ];
        builders = [ ./modules/x86builder.nix ];
      in
      {
        homeConfigurations = {
          natto = inputs.home-manager.lib.homeManagerConfiguration {
            modules = [
              ./home/natto
              {
                home = {
                  homeDirectory = "/home/natto";
                  username = "natto";
                  packages = [
                    inputs.home-manager.defaultPackage.x86_64-linux
                  ];
                  stateVersion = "22.05";
                };
              }
            ] ++ homeModules;
            pkgs = self.legacyPackages.x86_64-linux;
          };
        };

        nixosConfigurations = {
          #Home laptop
          satori = nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            modules = [
              ./hosts/satori
              {
                nixpkgs.pkgs = self.legacyPackages.${system};
              }
            ]
            ++ personalModules
            ++ commonModules;
          };

          #Home server (RPi4)
          marisa = nixpkgs.lib.nixosSystem rec {
            system = "aarch64-linux";
            modules = [
              ./hosts/marisa
              #inputs.mailserver.nixosModules.mailserver
              {
                nixpkgs.pkgs = self.legacyPackages.${system};
              }
            ]
            ++ commonModules
            ++ serverModules;
          };

          #Oracle Cloud VM
          remilia = nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            modules = [
              ./hosts/remilia
              inputs.mailserver.nixosModules.mailserver
              {
                nixpkgs.pkgs = self.legacyPackages.${system};
              }
            ]
            ++ commonModules
            ++ serverModules
            ++ builders;
          };
        };
      }
    );
}
