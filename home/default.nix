{ self, inputs, globalArgs, ... }:
let
  common = [
    ./common/zsh.nix
    ./common/programs.nix
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

  extraSpecialArgs = globalArgs;
in
{
  flake.homeConfigurations =
    let

      nattoModules = [
        ./natto
        ./common/laptop.nix
        inputs.agenix.homeManagerModules.default
      ] ++ common;
    in
    {
      natto-laptop = inputs.home-manager.lib.homeManagerConfiguration {
        inherit extraSpecialArgs;
        modules = nattoModules ++ [
          { isLaptop = true; }
        ];
        pkgs = mkPkgs "x86_64-linux";
      };

      natto = inputs.home-manager.lib.homeManagerConfiguration {
        inherit extraSpecialArgs;
        modules = nattoModules;
        pkgs = mkPkgs "x86_64-linux";
      };

    }

    // {
      spark = inputs.home-manager.lib.homeManagerConfiguration {
        inherit extraSpecialArgs;
        modules = [{
          home = {
            homeDirectory = "/home/spark";
            username = "spark";
            stateVersion = "23.05";
          };
        }] ++ common;
        pkgs = self.legacyPackages.aarch64-linux;
      };

      bat = inputs.home-manager.lib.homeManagerConfiguration {
        inherit extraSpecialArgs;
        modules = [{
          home = {
            homeDirectory = "/home/bat";
            username = "bat";
            stateVersion = "23.05";
          };
        }] ++ common;
        pkgs = self.legacyPackages.x86_64-linux;
      };

      spin = inputs.home-manager.lib.homeManagerConfiguration {
        inherit extraSpecialArgs;
        modules = [{
          home = {
            homeDirectory = "/home/spin";
            username = "spin";
            stateVersion = "23.05";
          };
        }] ++ common;
        pkgs = self.legacyPackages.x86_64-linux;
      };
    };
}
