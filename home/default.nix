{ self, inputs, globalArgs, ... }:
let
  commonModules = [
    ./modules/zsh.nix
    ./modules/programs.nix
    globalArgs
  ];
in
{
  flake.homeConfigurations = {
    natto = inputs.home-manager.lib.homeManagerConfiguration {
      modules = [
        ./natto
        ./modules/secret.nix
        inputs.hyprland.homeManagerModules.default
      ] ++ commonModules;
      pkgs = self.legacyPackages.x86_64-linux;
    };

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
