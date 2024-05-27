{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    stable.url = github:nixos/nixpkgs/release-23.11;
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
      # inputs.nixpkgs.follows = "nixpkgs";
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
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
      #     inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = github:hyprwm/contrib;
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl-gtk = {
      url = github:ezKEa/aagl-gtk-on-nix;
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
        };
    };
}
