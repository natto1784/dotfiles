{ self, inputs, ... }:
{
  flake.homeConfigurations = {
    natto = inputs.home-manager.lib.homeManagerConfiguration {
      modules = [
        ./natto
        ./modules/secret.nix
      ];
      pkgs = self.legacyPackages.x86_64-linux;
      extraSpecialArgs = {
        inherit inputs;
        flake = self;
      };
    };
  };
}
