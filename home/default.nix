{ self, inputs, globalArgs, ... }:
{
  flake.homeConfigurations = {
    natto = inputs.home-manager.lib.homeManagerConfiguration {
      modules = [
        ./natto
        ./modules/secret.nix
        inputs.hyprland.homeManagerModules.default
        globalArgs
      ];
      pkgs = self.legacyPackages.x86_64-linux;
    };
  };
}
