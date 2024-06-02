{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;

    stable.url = github:nixos/nixpkgs/release-24.05;

    flake-parts.url = github:hercules-ci/flake-parts;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mailserver = {
      url = gitlab:simple-nixos-mailserver/nixos-mailserver;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    filehost = {
      url = github:natto1784/simpler-filehost;
    };

    nix-gaming.url = github:fufexan/nix-gaming;

    nbfc = {
      url = github:nbfc-linux/nbfc-linux;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = github:nix-community/emacs-overlay;

    nvim-overlay.url = github:nix-community/neovim-nightly-overlay;

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };

    hyprland-contrib = {
      url = github:hyprwm/contrib;
    };

    agenix.url = github:ryantm/agenix;

    ags.url = github:Aylur/ags;
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      imports = [
        ./hosts
        ./home
        ./pkgs
        ./conf
      ];

      perSystem = { system, pkgs, ... }:
        rec {
          formatter = pkgs.nixpkgs-fmt;
          devShells.default = with pkgs; mkShell {
            packages = [
              nixd
              formatter
            ];
          };
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
          };
        };
    };
}
