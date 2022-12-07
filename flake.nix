{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    home-manager.url = github:nix-community/home-manager;
    flake-parts.url = github:hercules-ci/flake-parts;
    nvim-overlay.url = github:nix-community/neovim-nightly-overlay;
    mailserver.url = gitlab:simple-nixos-mailserver/nixos-mailserver;
    emacs-overlay.url = github:nix-community/emacs-overlay;
    rust-overlay.url = github:oxalica/rust-overlay;
    nix-gaming.url = github:fufexan/nix-gaming;
    nbfc.url = github:nbfc-linux/nbfc-linux;
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    inputs.flake-parts.lib.mkFlake { inherit self; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];
      imports = [
        ./hosts
        ./home
        ./pkgs
      ];

      perSystem = { pkgs, system, ... }: rec {
        legacyPackages = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            inputs.nvim-overlay.overlay
            inputs.emacs-overlay.overlay
            inputs.rust-overlay.overlays.default
          ];
        };

        formatter = pkgs.nixpkgs-fmt;

        devShells.default = pkgs.mkShell {
          packages = [ formatter ];
        };
      };
    };
}
