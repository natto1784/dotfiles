{ inputs, self, ... }:
{
  imports = [
    {
      config._module.args.globalArgs = {
        _module.args = {
          inherit inputs self;
          flake = self;
          colors = import ./colors.nix;
          network = import ./network.nix;
        };
      };
    }
  ];
}