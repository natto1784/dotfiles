{ self, inputs, globalArgs, ... }:
let
  commonModules = [
    ./modules/zsh.nix
    ./modules/programs.nix
    globalArgs
  ];

  mkPkgs = system: import inputs.nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = true;
    };
    overlays = [ self.overlays.default ];
  };
in
{
  flake.homeConfigurations =
    let

      nattoModules = [
        ./natto
        ./modules/laptop.nix
        inputs.hyprland.homeManagerModules.default
        inputs.agenix.homeManagerModules.default
      ] ++ commonModules;
    in
    {
      natto-laptop = inputs.home-manager.lib.homeManagerConfiguration {
        modules = nattoModules ++ [
          { natto.laptop = true; }
        ];
        pkgs = mkPkgs "x86_64-linux";
      };

      natto = inputs.home-manager.lib.homeManagerConfiguration {
        modules = nattoModules;
        pkgs = mkPkgs "x86_64-linux";
      };

    }

    // {
      spark = inputs.home-manager.lib.homeManagerConfiguration {
        modules = [{
          home = {
            homeDirectory = "/home/spark";
            username = "spark";
            stateVersion = "23.05";
          };
        }] ++ commonModules;
        pkgs = self.legacyPackages.aarch64-linux;
      };

      bat = inputs.home-manager.lib.homeManagerConfiguration {
        modules = [{
          home = {
            homeDirectory = "/home/bat";
            username = "bat";
            stateVersion = "23.05";
          };
        }] ++ commonModules;
        pkgs = self.legacyPackages.x86_64-linux;
      };

      spin = inputs.home-manager.lib.homeManagerConfiguration {
        modules = [{
          home = {
            homeDirectory = "/home/spin";
            username = "spin";
            stateVersion = "23.05";
          };
        }] ++ commonModules;
        pkgs = self.legacyPackages.x86_64-linux;
      };
    };
}
