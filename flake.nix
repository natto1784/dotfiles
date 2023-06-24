{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    stable.url = github:nixos/nixpkgs/release-22.11;
    flake-parts.url = github:hercules-ci/flake-parts;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mailserver = {
      url = gitlab:simple-nixos-mailserver/nixos-mailserver;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = github:oxalica/rust-overlay;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = github:fufexan/nix-gaming;
    nbfc = {
      url = github:nbfc-linux/nbfc-linux;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = github:nix-community/emacs-overlay;
    nvim-overlay = {
      url = github:nix-community/neovim-nightly-overlay;
      #     inputs.nixpkgs.url = github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836;
    };
    hyprland = {
      url = github:hyprwm/Hyprland;
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = github:hyprwm/contrib;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      imports = [
        ./hosts
        ./home
        ./pkgs
        ./lib
      ];

      perSystem = { pkgs, system, ... }: rec {
        legacyPackages = import inputs.nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            allowBroken = true;
            allowInsecure = true;
          };
          overlays = [
            inputs.nvim-overlay.overlay
            inputs.emacs-overlay.overlay
            inputs.rust-overlay.overlays.default
          ];
        };

        formatter = pkgs.nixpkgs-fmt;
      };
    };
}
