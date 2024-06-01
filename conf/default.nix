{ inputs, self, ... }:
{
  config._module.args.globalArgs = {
    inherit inputs self;
    flake = self;
    conf = {
      colors = import ./colors.nix;
      network = import ./network.nix;
    };
  };
}
